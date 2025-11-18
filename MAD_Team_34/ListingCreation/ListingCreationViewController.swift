//
//  ListingCreationViewController.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/12/25.
//

import UIKit
import CoreLocation
import MapKit

class ListingCreationViewController: UIViewController {
    
    var onListingCreated: ((PetListing) -> Void)?
    
    let listingCreationView = ListingCreationView()
    
    let geocoder = CLGeocoder()
    var selectedCoordinates: CLLocationCoordinate2D?
    var selectedImage: UIImage?
    var selectedDates: [Date] = []
    var selectedTimeIntervals: [String] = []
    
    override func loadView() {
        view = listingCreationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create New Pet Listing"
        
        listingCreationView.buttonCalibrate.addTarget(self, action: #selector(onButtonCalibrateTapped), for: .touchUpInside)
        listingCreationView.buttonSelectImage.addTarget(self, action: #selector(onButtonSelectImageTapped), for: .touchUpInside)
        listingCreationView.buttonSubmit.addTarget(self, action: #selector(onButtonSubmitTapped), for: .touchUpInside)
        
        listingCreationView.textViewDescription.delegate = self
        
        listingCreationView.mapView.delegate = self
        
        setupCalendar()
        
        setupTimeIntervalButtons()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        listingCreationView.mapView.addGestureRecognizer(tapGesture)
        
        setupKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
            selectedTimeIntervals.removeAll { $0 == timeInterval }
            sender.backgroundColor = .systemGray6
            sender.setTitleColor(.systemBlue, for: .normal)
            sender.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
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
    
    @objc func onButtonCalibrateTapped() {
        let locationAddress = listingCreationView.textFieldLocation.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if locationAddress.isEmpty {
            showAlert(message: "Please enter an address first before calibrating.")
            return
        }
        
        listingCreationView.buttonCalibrate.setTitle("Calibrating...", for: .normal)
        listingCreationView.buttonCalibrate.isEnabled = false
        
        geocoder.geocodeAddressString(locationAddress) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            self.listingCreationView.buttonCalibrate.setTitle("Calibrate Location", for: .normal)
            self.listingCreationView.buttonCalibrate.isEnabled = true
            
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                self.showAlert(message: "Unable to find this address. Please check the location and try again.")
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                self.selectedCoordinates = location.coordinate
                
                let region = MKCoordinateRegion(center: location.coordinate,
                                              latitudinalMeters: 2000,
                                              longitudinalMeters: 2000)
                self.listingCreationView.mapView.setRegion(region, animated: true)
                
                self.listingCreationView.mapView.removeAnnotations(self.listingCreationView.mapView.annotations)
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                annotation.title = "Selected Location"
                self.listingCreationView.mapView.addAnnotation(annotation)
                
                self.listingCreationView.mapView.removeOverlays(self.listingCreationView.mapView.overlays)
                let circle = MKCircle(center: location.coordinate, radius: 1609.34) // 1 mile in meters
                self.listingCreationView.mapView.addOverlay(circle)
                
            } else {
                self.showAlert(message: "Unable to find coordinates for this address. Please try a different address.")
            }
        }
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
    
    func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: listingCreationView.mapView)
        let coordinate = listingCreationView.mapView.convert(point, toCoordinateFrom: listingCreationView.mapView)
        selectedCoordinates = coordinate
        
        listingCreationView.mapView.removeAnnotations(listingCreationView.mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Selected Location"
        listingCreationView.mapView.addAnnotation(annotation)
        
        listingCreationView.mapView.removeOverlays(listingCreationView.mapView.overlays)
        let circle = MKCircle(center: coordinate, radius: 1609.34)
        listingCreationView.mapView.addOverlay(circle)
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let placemark = placemarks?.first {
                let address = [placemark.name, placemark.locality, placemark.administrativeArea, placemark.country]
                    .compactMap { $0 }
                    .joined(separator: ", ")
                self?.listingCreationView.textFieldLocation.text = address
            }
        }
    }
    
    @objc func onButtonSubmitTapped() {
        let name = listingCreationView.textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let description = listingCreationView.textViewDescription.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let pricing = listingCreationView.textFieldPricing.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let locationAddress = listingCreationView.textFieldLocation.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if name.isEmpty {
            showAlert(message: "Please enter a pet name.")
            return
        }
        
        if description.isEmpty || description == "Enter pet description (breed, age, temperament, etc.)" {
            showAlert(message: "Please enter a pet description.")
            return
        }
        
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
        
        if locationAddress.isEmpty {
            showAlert(message: "Please enter a location address.")
            return
        }
        
        if selectedImage == nil {
            showAlert(message: "Please select a pet photo.")
            return
        }
        
        if let coordinates = selectedCoordinates {
            let petListing = PetListing(
                name: name,
                petImage: selectedImage,
                description: description,
                pricing: pricing,
                availableDates: selectedDates,
                availableTimeIntervals: selectedTimeIntervals,
                locationAddress: locationAddress,
                coordinates: coordinates
                
            )
            
            onListingCreated?(petListing)
            
            navigationController?.popViewController(animated: true)
        } else {
            geocoder.geocodeAddressString(locationAddress) { [weak self] (placemarks, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Geocoding error: \(error.localizedDescription)")
                    self.showAlert(message: "Unable to find this address. Please check the location and try again.")
                    return
                }
                
                if let placemark = placemarks?.first, let location = placemark.location {
                    let petListing = PetListing(
                        name: name,
                        petImage: self.selectedImage,
                        description: description,
                        pricing: pricing,
                        availableDates: self.selectedDates,
                        availableTimeIntervals: self.selectedTimeIntervals,
                        locationAddress: locationAddress,
                        coordinates: location.coordinate
                        
                    )
                    
                    self.onListingCreated?(petListing)
                    
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.showAlert(message: "Unable to find coordinates for this address. Please try calibrating the location first.")
                }
            }
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ListingCreationViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter pet description (breed, age, temperament, etc.)" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter pet description (breed, age, temperament, etc.)"
            textView.textColor = .lightGray
        }
    }
}

extension ListingCreationViewController: MKMapViewDelegate {
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

extension ListingCreationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            listingCreationView.imageViewPet.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            listingCreationView.imageViewPet.image = originalImage
        }
        
        listingCreationView.imageViewPet.backgroundColor = .clear
        listingCreationView.imageViewPet.tintColor = .clear
        listingCreationView.imageViewPet.layer.borderColor = UIColor.systemBlue.cgColor
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
