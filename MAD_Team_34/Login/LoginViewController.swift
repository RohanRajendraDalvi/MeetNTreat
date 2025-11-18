//
//  LoginViewController.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/13/25.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonActions()
        setupKeyboardDismissal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupButtonActions() {
        loginView.loginButton.addTarget(self,
                                        action: #selector(loginTapped),
                                        for: .touchUpInside)
        loginView.signupButton.addTarget(self,
                                         action: #selector(signupTapped),
                                         for: .touchUpInside)
    }
    
    private func setupKeyboardDismissal() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func loginTapped() {
        guard let email = loginView.emailTextField.text, !email.isEmpty,
              let password = loginView.passwordTextField.text, !password.isEmpty else {
            loginView.showError("Please fill in all fields")
            return
        }
        
        UserManager.shared.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    CurrentUser.shared.user = user
                    
                    let homeVC = HomeScreenViewController()
                    self?.navigationController?.setViewControllers([homeVC], animated: true)
                    
                case .failure(let error):
                    self?.loginView.showError(error.localizedDescription)
                }
            }
        }
    }

    
    @objc private func signupTapped() {
        let signupVC = SignupViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: email)
    }
}
