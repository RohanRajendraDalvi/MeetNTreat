//
//  AddPetViewController.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/13/25.
//

import UIKit
import CoreLocation
import MapKit

class AddPetViewController: UIViewController {
    
    let addPetView = AddPetView()
    let geocoder = CLGeocoder()
    var selectedCoordinates: CLLocationCoordinate2D?
    var selectedImage: UIImage?
    
    override func loadView() {
        view = addPetView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Pet"
        setupActions()
        setupDelegates()
        setupKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupActions() {
        addPetView.buttonSelectImage.addTarget(self, action: #selector(onButtonSelectImageTapped), for: .touchUpInside)
        addPetView.buttonCalibrate.addTarget(self, action: #selector(onButtonCalibrateTapped), for: .touchUpInside)
        addPetView.buttonAddPet.addTarget(self, action: #selector(onButtonAddPetTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        addPetView.mapView.addGestureRecognizer(tapGesture)
    }
    
    private func setupDelegates() {
        addPetView.textViewDescription.delegate = self
        addPetView.mapView.delegate = self
    }
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func onButtonSelectImageTapped() {
        let alertController = UIAlertController(title: "Select Photo", message: "Choose a photo source", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.openCamera()
        }
        
        let galleryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.openPhotoLibrary()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func onButtonCalibrateTapped() {
        let locationAddress = addPetView.textFieldLocation.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if locationAddress.isEmpty {
            showAlert(message: "Please enter an address first before calibrating.")
            return
        }
        
        addPetView.buttonCalibrate.setTitle("Calibrating...", for: .normal)
        addPetView.buttonCalibrate.isEnabled = false
        
        geocoder.geocodeAddressString(locationAddress) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            self.addPetView.buttonCalibrate.setTitle("Calibrate Location", for: .normal)
            self.addPetView.buttonCalibrate.isEnabled = true
            
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                self.showAlert(message: "Unable to find this address. Please check the location and try again.")
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                self.selectedCoordinates = location.coordinate
                self.updateMapWithLocation(location.coordinate)
            } else {
                self.showAlert(message: "Unable to find coordinates for this address. Please try a different address.")
            }
        }
    }
    
    @objc func onButtonAddPetTapped() {
        let name = addPetView.textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let age = addPetView.textFieldAge.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let description = addPetView.textViewDescription.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let locationAddress = addPetView.textFieldLocation.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        // Validation
        if name.isEmpty {
            showAlert(message: "Please enter a pet name.")
            return
        }
        
        if age.isEmpty {
            showAlert(message: "Please enter pet's age.")
            return
        }
        
        if description.isEmpty || description == "Enter pet description (breed, temperament, etc.)" {
            showAlert(message: "Please enter a pet description.")
            return
        }
        
        if locationAddress.isEmpty {
            showAlert(message: "Please enter a location address.")
            return
        }
        
        if selectedImage == nil {
            showAlert(message: "Please select a pet photo.")
            return
        }
        
        // Create pet object and save to Firebase (you'll implement this)
        let pet = Pet(
            name: name,
            age: age,
            description: description,
            locationAddress: locationAddress,
            coordinates: selectedCoordinates,
            petImage: selectedImage
        )
        
        // Save pet to Firebase and navigate back
        savePetToFirebase(pet)
    }
    
    @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: addPetView.mapView)
        let coordinate = addPetView.mapView.convert(point, toCoordinateFrom: addPetView.mapView)
        selectedCoordinates = coordinate
        
        addPetView.mapView.removeAnnotations(addPetView.mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Pet Location"
        addPetView.mapView.addAnnotation(annotation)
        
        // Reverse geocode to get address
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let placemark = placemarks?.first {
                let address = [placemark.name, placemark.locality, placemark.administrativeArea, placemark.country]
                    .compactMap { $0 }
                    .joined(separator: ", ")
                self?.addPetView.textFieldLocation.text = address
            }
        }
    }
    
    private func updateMapWithLocation(_ location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 2000, longitudinalMeters: 2000)
        addPetView.mapView.setRegion(region, animated: true)
        
        addPetView.mapView.removeAnnotations(addPetView.mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Pet Location"
        addPetView.mapView.addAnnotation(annotation)
    }
    
    private func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func openPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func savePetToFirebase(_ pet: Pet) {
        // TODO: Implement Firebase save logic
        // For now, just show success and pop back
        showAlert(message: "Pet added successfully!") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        addPetView.scrollView.contentInset = contentInset
        addPetView.scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        addPetView.scrollView.contentInset = .zero
        addPetView.scrollView.scrollIndicatorInsets = .zero
    }
}

// MARK: - UITextViewDelegate
extension AddPetViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter pet description (breed, temperament, etc.)" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter pet description (breed, temperament, etc.)"
            textView.textColor = .lightGray
        }
    }
}

// MARK: - MKMapViewDelegate
extension AddPetViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: circleOverlay)
            circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.1)
            circleRenderer.strokeColor = UIColor.blue
            circleRenderer.lineWidth = 2
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension AddPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            addPetView.imageViewPet.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            addPetView.imageViewPet.image = originalImage
        }
        
        addPetView.imageViewPet.backgroundColor = .clear
        addPetView.imageViewPet.tintColor = .clear
        addPetView.imageViewPet.layer.borderColor = UIColor.systemBlue.cgColor
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Pet Model
struct Pet {
    let name: String
    let age: String
    let description: String
    let locationAddress: String
    let coordinates: CLLocationCoordinate2D?
    let petImage: UIImage?
}
