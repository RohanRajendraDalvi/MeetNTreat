//
//  CurrentUser.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/15/25.
//


import Foundation

class CurrentUser {
    static let shared = CurrentUser()
    private init() {}

    var user: AppUser?
}
