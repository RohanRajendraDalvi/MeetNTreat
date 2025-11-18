//
// AppUser.swift
// MAD_Team_34
//
// Created by Student 2 on 11/13/25.
//

import Foundation
import FirebaseFirestore

struct AppUser: Codable {
    var uid: String
    var name: String
    var email: String
    var photoURL: String?
    var joinDate: Date

    var memberSinceText: String {
        let df = DateFormatter()
        df.dateFormat = "MMMM yyyy"
        return "Member since \(df.string(from: joinDate))"
    }
}
