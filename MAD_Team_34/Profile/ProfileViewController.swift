//
//  ProfileViewController.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/13/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource {
    
    var profileView = ProfileView()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    // Data for table view
    let myPetsData = ["My Pets"]
    
    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupTableView()
        loadUserData()
        
        // Debug: Check navigation controller
        print("Navigation controller: \(String(describing: navigationController))")
    }
    
    private func setupActions() {
        profileView.changePhotoButton.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
        profileView.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        profileView.tableView.dataSource = self
        profileView.tableView.delegate = self
        profileView.tableView.isScrollEnabled = false // Since we only have one row
    }
    
    private func loadUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(uid).getDocument { [weak self] snapshot, error in
            guard let self = self else { return }
            if let data = snapshot?.data() {
                
                self.profileView.nameLabel.text = data["fullName"] as? String ?? "Unknown"
                self.profileView.emailLabel.text = data["email"] as? String ?? ""
                
                if let urlString = data["profileImageUrl"] as? String,
                   let url = URL(string: urlString) {
                    self.loadImage(from: url)
                }
            }
        }
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.profileView.profileImageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }

    @objc private func changePhotoTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage,
              let uid = Auth.auth().currentUser?.uid else { return }
        
        profileView.profileImageView.image = image
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let ref = storage.reference().child("profileImages/\(uid).jpg")
        
        ref.putData(imageData) { [weak self] _, error in
            guard let self = self else { return }
            if error == nil {
                ref.downloadURL { url, _ in
                    guard let url = url else { return }
                    
                    self.db.collection("users").document(uid).updateData([
                        "profileImageUrl": url.absoluteString
                    ])
                }
            }
        }
    }
    
    @objc private func logoutTapped() {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true)
        } catch {
            print("Error logging out:", error)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPetsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = myPetsData[indexPath.row]
        cell.accessoryType = .disclosureIndicator // Add arrow on the right
        cell.selectionStyle = .default
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("My Pets tapped - Navigating to MyPetsViewController")
        
        if indexPath.row == 0 { // "My Pets" row
            let myPetsVC = MyPetsViewController()
            
            // Check if we have a navigation controller
            if let navController = self.navigationController {
                print("Using navigation controller push")
                navController.pushViewController(myPetsVC, animated: true)
            } else {
                print("No navigation controller found - presenting modally")
                // If no navigation controller, present modally with navigation
                let navController = UINavigationController(rootViewController: myPetsVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
        }
    }
}
