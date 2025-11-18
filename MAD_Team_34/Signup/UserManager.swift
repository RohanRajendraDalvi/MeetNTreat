//
//  UserManager.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/13/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import UIKit

class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    private let defaultAvatarURL = "https://i.pravatar.cc/300"
    
    func registerUser(name: String,
                      email: String,
                      password: String,
                      image: UIImage?,
                      completion: @escaping (Result<AppUser, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error { completion(.failure(error)); return }
            guard let firebaseUser = authResult?.user else {
                completion(.failure(NSError(domain: "UserManager",
                                            code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "Failed to create user"])))
                return
            }
            
            self.uploadProfileImage(uid: firebaseUser.uid, image: image) { result in
                switch result {
                    
                case .success(let urlString):
                    let changeRequest = firebaseUser.createProfileChangeRequest()
                    changeRequest.displayName = name
                    if let urlString = urlString, let url = URL(string: urlString) {
                        changeRequest.photoURL = url
                    }
                    changeRequest.commitChanges(completion: nil)
                    
                    let appUser = AppUser(uid: firebaseUser.uid,
                                          name: name,
                                          email: email,
                                          photoURL: urlString ?? self.defaultAvatarURL,
                                          joinDate: Date())
                    
                    do {
                        let data = try Firestore.Encoder().encode(appUser)
                        self.db.collection("users").document(firebaseUser.uid).setData(data) { err in
                            if let err = err { completion(.failure(err)) }
                            else { completion(.success(appUser)) }
                        }
                    } catch {
                        completion(.failure(error))
                    }
                    
                case .failure(let err):
                    completion(.failure(err))
                }
            }
        }
    }
    
    private func uploadProfileImage(uid: String,
                                    image: UIImage?,
                                    completion: @escaping (Result<String?, Error>) -> Void) {
        
        guard let image = image else {
            completion(.success(defaultAvatarURL))
            return
        }
        
        let ref = storage.reference().child("profile_images/\(uid).jpg")
        guard let data = image.jpegData(compressionQuality: 0.75) else {
            completion(.success(defaultAvatarURL))
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        ref.putData(data, metadata: metadata) { _, error in
            if let error = error { completion(.failure(error)); return }
            
            ref.downloadURL { url, error in
                if let error = error { completion(.failure(error)); return }
                
                completion(.success(url?.absoluteString ?? self.defaultAvatarURL))
            }
        }
    }
    
    func fetchCurrentUser(completion: @escaping (AppUser?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        db.collection("users").document(uid).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else {
                completion(nil)
                return
            }
            
            do {
                let user = try Firestore.Decoder().decode(AppUser.self, from: data)
                completion(user)
            } catch {
                completion(nil)
            }
        }
    }
    
    
    func updateProfile(name: String,
                       image: UIImage?,
                       completion: @escaping (Bool) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { completion(false); return }
        
        if let img = image {
            
            uploadProfileImage(uid: uid, image: img) { result in
                switch result {
                case .success(let urlString):
                    self.updateUserDocument(uid: uid, name: name, photoURL: urlString, completion: completion)
                case .failure(_):
                    completion(false)
                }
            }
            
        } else {
            updateUserDocument(uid: uid, name: name, photoURL: nil, completion: completion)
        }
    }
    
    
    private func updateUserDocument(uid: String,
                                    name: String,
                                    photoURL: String?,
                                    completion: @escaping (Bool) -> Void) {
        
        var updateData: [String: Any] = ["name": name]
        
        if let photoURL = photoURL {
            updateData["photoURL"] = photoURL
        }
        
        db.collection("users").document(uid).updateData(updateData) { error in
            completion(error == nil)
        }
    }
    
    
    func updateProfileImage(image: UIImage,
                            completion: @escaping (String?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        uploadProfileImage(uid: uid, image: image) { result in
            switch result {
            case .success(let url):
                if let url = url {
                    self.db.collection("users").document(uid).updateData([
                        "photoURL": url
                    ])
                }
                completion(url)
                
            case .failure(_):
                completion(nil)
            }
        }
    }
  
    func login(email: String,
               password: String,
               completion: @escaping (Result<AppUser, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let firebaseUser = authResult?.user else {
                completion(.failure(NSError(domain: "UserManager",
                                            code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "Failed to login"])))
                return
            }
            
            self.db.collection("users").document(firebaseUser.uid).getDocument { snapshot, err in
                if let err = err {
                    completion(.failure(err))
                    return
                }
                
                guard let data = snapshot?.data() else {
                    completion(.failure(NSError(domain: "UserManager",
                                                code: -2,
                                                userInfo: [NSLocalizedDescriptionKey: "User data not found"])))
                    return
                }
                
                do {
                    let user = try Firestore.Decoder().decode(AppUser.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }

    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
}
