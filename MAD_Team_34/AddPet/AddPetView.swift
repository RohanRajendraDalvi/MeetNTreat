//
//  AddPetView.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/13/25.
//

import UIKit
import MapKit

class AddPetView: UIView {

    var scrollView: UIScrollView!
    var contentView: UIView!
    
    // Name Section
    var labelNameTitle: UILabel!
    var textFieldName: UITextField!
    
    // Age Section
    var labelAgeTitle: UILabel!
    var textFieldAge: UITextField!
    
    // Description Section
    var labelDescriptionTitle: UILabel!
    var textViewDescription: UITextView!
    
    // Location Section
    var labelLocationTitle: UILabel!
    var textFieldLocation: UITextField!
    var buttonCalibrate: UIButton!
    var mapView: MKMapView!
    
    // Image Section
    var labelImageTitle: UILabel!
    var imageViewPet: UIImageView!
    var buttonSelectImage: UIButton!
    
    var buttonAddPet: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupScrollView()
        setupNameSection()
        setupAgeSection()
        setupDescriptionSection()
        setupLocationSection()
        setupImageSection()
        setupButtonAddPet()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: initializing the UI elements...
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
    func setupNameSection(){
        labelNameTitle = UILabel()
        labelNameTitle.text = "Pet Name:"
        labelNameTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelNameTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelNameTitle)
        
        textFieldName = UITextField()
        textFieldName.placeholder = "Enter pet name"
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textFieldName)
    }
    
    func setupAgeSection(){
        labelAgeTitle = UILabel()
        labelAgeTitle.text = "Pet Age:"
        labelAgeTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelAgeTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelAgeTitle)
        
        textFieldAge = UITextField()
        textFieldAge.placeholder = "Enter pet age (e.g., 2 years, 5 months)"
        textFieldAge.borderStyle = .roundedRect
        textFieldAge.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textFieldAge)
    }
    
    func setupDescriptionSection(){
        labelDescriptionTitle = UILabel()
        labelDescriptionTitle.text = "Pet Description:"
        labelDescriptionTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelDescriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelDescriptionTitle)
        
        textViewDescription = UITextView()
        textViewDescription.text = "Enter pet description (breed, temperament, etc.)"
        textViewDescription.font = UIFont.systemFont(ofSize: 16)
        textViewDescription.layer.borderWidth = 1.0
        textViewDescription.layer.borderColor = UIColor.systemGray4.cgColor
        textViewDescription.layer.cornerRadius = 8
        textViewDescription.textColor = .lightGray
        textViewDescription.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textViewDescription)
    }
    
    func setupLocationSection(){
        labelLocationTitle = UILabel()
        labelLocationTitle.text = "Location:"
        labelLocationTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelLocationTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelLocationTitle)
        
        textFieldLocation = UITextField()
        textFieldLocation.placeholder = "Enter location/address"
        textFieldLocation.borderStyle = .roundedRect
        textFieldLocation.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textFieldLocation)
        
        buttonCalibrate = UIButton(type: .system)
        buttonCalibrate.setTitle("Calibrate Location", for: .normal)
        buttonCalibrate.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        buttonCalibrate.backgroundColor = .systemBlue
        buttonCalibrate.setTitleColor(.white, for: .normal)
        buttonCalibrate.layer.cornerRadius = 8
        buttonCalibrate.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonCalibrate)
        
        mapView = MKMapView()
        mapView.layer.cornerRadius = 8
        mapView.layer.borderWidth = 1.0
        mapView.layer.borderColor = UIColor.systemGray4.cgColor
        mapView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapView)
        
        setupWorldMapView()
    }
    
    func setupWorldMapView() {
        let center = CLLocationCoordinate2D(latitude: 20, longitude: 0)
        let span = MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: false)
    }
    
    func setupImageSection(){
        labelImageTitle = UILabel()
        labelImageTitle.text = "Pet Photo:"
        labelImageTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelImageTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelImageTitle)
        
        imageViewPet = UIImageView()
        imageViewPet.image = UIImage(systemName: "photo")
        imageViewPet.contentMode = .scaleAspectFill
        imageViewPet.clipsToBounds = true
        imageViewPet.layer.cornerRadius = 12
        imageViewPet.layer.borderWidth = 2
        imageViewPet.layer.borderColor = UIColor.systemGray4.cgColor
        imageViewPet.backgroundColor = .systemGray6
        imageViewPet.tintColor = .systemGray3
        imageViewPet.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageViewPet)
        
        buttonSelectImage = UIButton(type: .system)
        buttonSelectImage.setTitle("Select Photo", for: .normal)
        buttonSelectImage.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        buttonSelectImage.backgroundColor = .systemOrange
        buttonSelectImage.setTitleColor(.white, for: .normal)
        buttonSelectImage.layer.cornerRadius = 8
        buttonSelectImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonSelectImage)
    }
    
    func setupButtonAddPet(){
        buttonAddPet = UIButton(type: .system)
        buttonAddPet.setTitle("Add Pet", for: .normal)
        buttonAddPet.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        buttonAddPet.backgroundColor = .systemGreen
        buttonAddPet.setTitleColor(.white, for: .normal)
        buttonAddPet.layer.cornerRadius = 8
        buttonAddPet.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonAddPet)
    }
    
    //MARK: initializing constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            // Scroll View constraints
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            // Content View constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Name section constraints
            labelNameTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            labelNameTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelNameTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            textFieldName.topAnchor.constraint(equalTo: labelNameTitle.bottomAnchor, constant: 8),
            textFieldName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textFieldName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            textFieldName.heightAnchor.constraint(equalToConstant: 44),
            
            // Age section constraints
            labelAgeTitle.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            labelAgeTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelAgeTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            textFieldAge.topAnchor.constraint(equalTo: labelAgeTitle.bottomAnchor, constant: 8),
            textFieldAge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textFieldAge.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            textFieldAge.heightAnchor.constraint(equalToConstant: 44),
            
            // Description section constraints
            labelDescriptionTitle.topAnchor.constraint(equalTo: textFieldAge.bottomAnchor, constant: 16),
            labelDescriptionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelDescriptionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            textViewDescription.topAnchor.constraint(equalTo: labelDescriptionTitle.bottomAnchor, constant: 8),
            textViewDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textViewDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            textViewDescription.heightAnchor.constraint(equalToConstant: 120),
            
            // Location section constraints
            labelLocationTitle.topAnchor.constraint(equalTo: textViewDescription.bottomAnchor, constant: 16),
            labelLocationTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelLocationTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            textFieldLocation.topAnchor.constraint(equalTo: labelLocationTitle.bottomAnchor, constant: 8),
            textFieldLocation.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textFieldLocation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            textFieldLocation.heightAnchor.constraint(equalToConstant: 44),
            
            buttonCalibrate.topAnchor.constraint(equalTo: textFieldLocation.bottomAnchor, constant: 16),
            buttonCalibrate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            buttonCalibrate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            buttonCalibrate.heightAnchor.constraint(equalToConstant: 44),
            
            mapView.topAnchor.constraint(equalTo: buttonCalibrate.bottomAnchor, constant: 16),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            mapView.heightAnchor.constraint(equalToConstant: 200),
            
            // Image section constraints
            labelImageTitle.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 24),
            labelImageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelImageTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            imageViewPet.topAnchor.constraint(equalTo: labelImageTitle.bottomAnchor, constant: 16),
            imageViewPet.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageViewPet.widthAnchor.constraint(equalToConstant: 150),
            imageViewPet.heightAnchor.constraint(equalToConstant: 150),
            
            buttonSelectImage.topAnchor.constraint(equalTo: imageViewPet.bottomAnchor, constant: 16),
            buttonSelectImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonSelectImage.widthAnchor.constraint(equalToConstant: 150),
            buttonSelectImage.heightAnchor.constraint(equalToConstant: 44),
            
            // Add Pet button constraints
            buttonAddPet.topAnchor.constraint(equalTo: buttonSelectImage.bottomAnchor, constant: 32),
            buttonAddPet.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonAddPet.widthAnchor.constraint(equalToConstant: 200),
            buttonAddPet.heightAnchor.constraint(equalToConstant: 50),
            buttonAddPet.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
}
