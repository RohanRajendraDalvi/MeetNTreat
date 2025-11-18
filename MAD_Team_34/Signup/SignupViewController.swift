//
// SignupViewController.swift
// MAD_Team_34
//
// Created by Student 2 on 11/13/25.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {

    private let signupView = SignupView()
    private var selectedImage: UIImage?
    private let imagePicker = ImagePickerHelper()

    override func loadView() {
        view = signupView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupKeyboardDismissal()
        imagePicker.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        title = "Sign Up"
    }

    private func setupActions() {
        signupView.signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        signupView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        signupView.changePhotoButton.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)

        let tap = UITapGestureRecognizer(target: self, action: #selector(changePhotoTapped))
        signupView.profileImageView.isUserInteractionEnabled = true
        signupView.profileImageView.addGestureRecognizer(tap)
    }

    private func setupKeyboardDismissal() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func changePhotoTapped() {
        presentPhotoOptions()
    }

    private func presentPhotoOptions() {
        let alert = UIAlertController(title: "Profile Photo", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.imagePicker.openCamera(from: self)
        }))
        alert.addAction(UIAlertAction(title: "Choose from Gallery", style: .default, handler: { _ in
            self.imagePicker.openGallery(from: self)
        }))
        alert.addAction(UIAlertAction(title: "Use Default Avatar", style: .default, handler: { _ in
            self.selectedImage = nil
            self.signupView.profileImageView.image = UIImage(systemName: "person.circle.fill")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    @objc private func signupTapped() {
        guard let name = signupView.nameTextField.text, !name.isEmpty,
              let email = signupView.emailTextField.text, !email.isEmpty,
              let password = signupView.passwordTextField.text, !password.isEmpty,
              let confirm = signupView.confirmPasswordTextField.text, !confirm.isEmpty else {
            signupView.showError("Please fill in all fields")
            return
        }

        if !isValidEmail(email) {
            signupView.showError("Please enter a valid email")
            return
        }

        if password.count < 6 {
            signupView.showError("Password must be at least 6 characters")
            return
        }

        if password != confirm {
            signupView.showError("Passwords do not match")
            return
        }

        signupView.hideError()
        view.isUserInteractionEnabled = false

        UserManager.shared.registerUser(name: name, email: email, password: password, image: selectedImage) { result in
            DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = true
                switch result {
                case .success(let appUser):
                    CurrentUser.shared.user = appUser

                    let homeVC = HomeScreenViewController()
                    self.navigationController?.setViewControllers([homeVC], animated: true)

                case .failure(let error):
                    self.signupView.showError(error.localizedDescription)
                }
            }
        }
    }

    @objc private func loginTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension SignupViewController: ImagePickerHelperDelegate {
    func imagePickerHelper(_ helper: ImagePickerHelper, didSelect image: UIImage?) {
        guard let image = image else { return }
        selectedImage = image.fixOrientationAndResize(maxDimension: 1024)
        signupView.profileImageView.image = selectedImage
    }
}
