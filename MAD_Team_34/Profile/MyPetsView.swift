//
//  MyPetsView.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/13/25.
//

import UIKit

class MyPetsView: UIView {
    
    var addPetButton: UIButton!
    
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
        addPetButton = UIButton(type: .system)
        addPetButton.setTitle("Add Pet", for: .normal)
        addPetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        addPetButton.setTitleColor(.white, for: .normal)
        addPetButton.backgroundColor = .systemBlue
        addPetButton.layer.cornerRadius = 8
        addPetButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addPetButton)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            addPetButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addPetButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addPetButton.widthAnchor.constraint(equalToConstant: 200),
            addPetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
