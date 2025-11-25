//
//  ProfileView.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/13/25.
//

import UIKit

class ProfileView: UIView {
    
    var profileImageView: UIImageView!
    var changePhotoButton: UIButton!
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var tableView: UITableView!
    var logoutButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupUI()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        // Profile Image
        profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = .systemGray
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 60
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImageView)
        
        // Change Photo Button
        changePhotoButton = UIButton(type: .system)
        changePhotoButton.setTitle("Change Photo", for: .normal)
        changePhotoButton.titleLabel?.font = .systemFont(ofSize: 16)
        changePhotoButton.setTitleColor(.systemBlue, for: .normal)
        changePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(changePhotoButton)
        
        // Name Label
        nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        
        // Email Label
        emailLabel = UILabel()
        emailLabel.textAlignment = .center
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.textColor = .secondaryLabel
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
        
        // Table View
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.systemGray4.cgColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        
        // Logout Button
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = .systemRed
        logoutButton.layer.cornerRadius = 10
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoutButton)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            
            // Profile Image
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            // Change Photo Button
            changePhotoButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            changePhotoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Name Label
            nameLabel.topAnchor.constraint(equalTo: changePhotoButton.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Email Label
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Table View - ADDED ABOVE LOGOUT BUTTON
            tableView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 60), // Height for one row
            
            // Logout Button - NOW BELOW TABLE VIEW
            logoutButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 30),
            logoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
