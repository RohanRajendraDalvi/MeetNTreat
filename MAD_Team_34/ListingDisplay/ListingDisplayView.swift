//
//  DisplayView.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/12/25.
//

import UIKit

class ListingDisplayView: UIView {

    // Basic UI components to avoid errors
    var labelTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        labelTitle = UILabel()
        labelTitle.text = "Listing Details"
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.boldSystemFont(ofSize: 18)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTitle)
        
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
