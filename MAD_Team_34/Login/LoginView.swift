//
//  LoginView.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/13/25.
//

import UIKit

class LoginView: UIView {
  
    var titleLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!
    var errorLabel: UILabel!
    
    var googleButton: UIButton!
    
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
        
        titleLabel = UILabel()
        titleLabel.text = "Welcome Back"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.accessibilityIdentifier = "login_email"
        addSubview(emailTextField)
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.accessibilityIdentifier = "login_password"
        addSubview(passwordTextField)
        
        errorLabel = UILabel()
        errorLabel.text = ""
        errorLabel.font = UIFont.systemFont(ofSize: 14)
        errorLabel.textAlignment = .center
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorLabel)
        
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.accessibilityIdentifier = "login_button"
        addSubview(loginButton)
        
        signupButton = UIButton(type: .system)
        signupButton.setTitle("Don't have an account? Sign Up", for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        signupButton.setTitleColor(.systemBlue, for: .normal)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.accessibilityIdentifier = "go_to_signup"
        addSubview(signupButton)
        
        googleButton = UIButton(type: .system)
        googleButton.setTitle("Continue with Google", for: .normal)
        googleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        googleButton.setTitleColor(.white, for: .normal)
        googleButton.backgroundColor = .black
        googleButton.layer.cornerRadius = 8
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(googleButton)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            // Email
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Password
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Error Label
            errorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            // Login Button
            loginButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Signup Button
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 25),
            signupButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        
        // Enable if using Google login
        NSLayoutConstraint.activate([
            googleButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 30),
            googleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            googleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            googleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func hideError() {
        errorLabel.text = ""
        errorLabel.isHidden = true
    }
}
