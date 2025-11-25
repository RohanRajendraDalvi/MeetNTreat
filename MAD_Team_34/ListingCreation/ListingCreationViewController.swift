//
//  ListingCreationViewController.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/12/25.
//

import UIKit
import CoreLocation

class ListingCreationViewController: UIViewController {
    
    var onListingCreated: ((PetListing) -> Void)?
    
    let listingCreationView = ListingCreationView()
    
    var selectedImage: UIImage?
    var selectedDates: [Date] = []
    var selectedTimeIntervals: [String] = []
    
    // Pet selection data
    var userPets: [Pet] = [] // This will be populated from your user's pets
    var selectedPet: Pet?
    
    override func loadView() {
        view = listingCreationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create New Listing"
        
        // Setup targets
        listingCreationView.petDropdownButton.addTarget(self, action: #selector(onPetDropdownTapped), for: .touchUpInside)
        listingCreationView.buttonSubmit.addTarget(self, action: #selector(onButtonSubmitTapped), for: .touchUpInside)
        
        // Setup delegates
        listingCreationView.petDropdownTableView.dataSource = self
        listingCreationView.petDropdownTableView.delegate = self
        
        // Setup calendar
        setupCalendar()
        
        // Setup time interval buttons
        setupTimeIntervalButtons()
        
        // Setup gestures
        let tapOutsideGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideDropdown))
        tapOutsideGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOutsideGesture)
        
        setupKeyboardNotifications()
        loadUserPets() // Load user's pets for dropdown
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func loadUserPets() {
        // TODO: Load user's pets from Firebase
        // For now, empty array - no dummy values
        userPets = []
        
        listingCreationView.petDropdownTableView.reloadData()
    }
    
    func setupCalendar() {
        listingCreationView.calendarView.addTarget(self, action: #selector(onDateSelected), for: .valueChanged)
    }
    
    func setupTimeIntervalButtons() {
        for (index, button) in listingCreationView.timeIntervalButtons.enumerated() {
            button.tag = index
            button.addTarget(self, action: #selector(onTimeIntervalTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc func onDateSelected() {
        let selectedDate = listingCreationView.calendarView.date
        selectedDates = [selectedDate]
    }
    
    @objc func onTimeIntervalTapped(_ sender: UIButton) {
        guard let timeInterval = sender.titleLabel?.text else { return }
        
        if selectedTimeIntervals.contains(timeInterval) {
            // Deselect
            selectedTimeIntervals.removeAll { $0 == timeInterval }
            sender.backgroundColor = .systemGray6
            sender.setTitleColor(.systemBlue, for: .normal)
            sender.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            // Select (max 4)
            if selectedTimeIntervals.count < 4 {
                selectedTimeIntervals.append(timeInterval)
                sender.backgroundColor = .systemBlue
                sender.setTitleColor(.white, for: .normal)
                sender.layer.borderColor = UIColor.systemBlue.cgColor
            } else {
                showAlert(message: "You can select up to 4 time intervals only.")
            }
        }
    }
    
    @objc func onPetDropdownTapped() {
        listingCreationView.isDropdownExpanded.toggle()
        
        if listingCreationView.isDropdownExpanded {
            listingCreationView.petDropdownTableView.isHidden = false
            // Rotate arrow
            if let arrow = listingCreationView.petDropdownButton.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                UIView.animate(withDuration: 0.3) {
                    arrow.transform = CGAffineTransform(rotationAngle: .pi)
                }
            }
        } else {
            listingCreationView.petDropdownTableView.isHidden = true
            // Rotate arrow back
            if let arrow = listingCreationView.petDropdownButton.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                UIView.animate(withDuration: 0.3) {
                    arrow.transform = .identity
                }
            }
        }
    }
    
    @objc func handleTapOutsideDropdown() {
        if listingCreationView.isDropdownExpanded {
            listingCreationView.isDropdownExpanded = false
            listingCreationView.petDropdownTableView.isHidden = true
            // Rotate arrow back
            if let arrow = listingCreationView.petDropdownButton.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                UIView.animate(withDuration: 0.3) {
                    arrow.transform = .identity
                }
            }
        }
    }
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        listingCreationView.scrollView.contentInset = contentInset
        listingCreationView.scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        listingCreationView.scrollView.contentInset = .zero
        listingCreationView.scrollView.scrollIndicatorInsets = .zero
    }
    
    @objc func onButtonSubmitTapped() {
        guard let selectedPet = selectedPet else {
            showAlert(message: "Please select a pet.")
            return
        }
        
        let pricing = listingCreationView.textFieldPricing.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if pricing.isEmpty {
            showAlert(message: "Please enter a price.")
            return
        }
        
        if selectedDates.isEmpty {
            showAlert(message: "Please select at least one date.")
            return
        }
        
        if selectedTimeIntervals.isEmpty {
            showAlert(message: "Please select at least one time interval.")
            return
        }
        
        let petListing = PetListing(
            name: selectedPet.name,
            petImage: selectedPet.petImage, // Use pet's image
            description: selectedPet.description,
            pricing: pricing,
            availableDates: selectedDates,
            availableTimeIntervals: selectedTimeIntervals,
            locationAddress: "", // Empty since location was removed
            coordinates: nil // Empty since location was removed
        )
        
        onListingCreated?(petListing)
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource & Delegate
extension ListingCreationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "petCell", for: indexPath)
        let pet = userPets[indexPath.row]
        cell.textLabel?.text = "\(pet.name) - \(pet.description)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPet = userPets[indexPath.row]
        listingCreationView.petDropdownButton.setTitle("\(selectedPet!.name)", for: .normal)
        
        // Collapse dropdown
        listingCreationView.isDropdownExpanded = false
        listingCreationView.petDropdownTableView.isHidden = true
        
        // Rotate arrow back
        if let arrow = listingCreationView.petDropdownButton.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
            UIView.animate(withDuration: 0.3) {
                arrow.transform = .identity
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if userPets.isEmpty {
            let footerView = UIView()
            let label = UILabel()
            label.text = "No pets available. Please add pets first."
            label.textAlignment = .center
            label.textColor = .systemGray
            label.font = UIFont.systemFont(ofSize: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            footerView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
                label.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16)
            ])
            
            return footerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return userPets.isEmpty ? 50 : 0
    }
}
