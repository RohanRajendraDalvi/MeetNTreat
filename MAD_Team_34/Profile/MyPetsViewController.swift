//
//  MyPetsViewController.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/13/25.
//

import UIKit

class MyPetsViewController: UIViewController {
    
    let myPetsView = MyPetsView()
    
    override func loadView() {
        view = myPetsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Pets"
        setupActions()
    }
    
    private func setupActions() {
        myPetsView.addPetButton.addTarget(self, action: #selector(onAddPetTapped), for: .touchUpInside)
    }
    
    @objc private func onAddPetTapped() {
        let addPetVC = AddPetViewController()
        navigationController?.pushViewController(addPetVC, animated: true)
    }
}
