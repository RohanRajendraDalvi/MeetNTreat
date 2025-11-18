//
//  FirstScreenView.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/12/25.
//

import UIKit
import MapKit

class ListingCreationView: UIView {

    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var labelTitle: UILabel!
    
    var labelNameTitle: UILabel!
    var textFieldName: UITextField!
    
    var labelDescriptionTitle: UILabel!
    var textViewDescription: UITextView!
    
    var labelPricingTitle: UILabel!
    var textFieldPricing: UITextField!
    
    var labelCalendarTitle: UILabel!
    var calendarView: UIDatePicker!
    
    var labelTimeIntervalsTitle: UILabel!
    var timeIntervalStackView: UIStackView!
    var timeIntervalButtons: [UIButton] = []
    var selectedTimeIntervals: [String] = []
    
    var labelLocationTitle: UILabel!
    var textFieldLocation: UITextField!
    var buttonCalibrate: UIButton!
    var mapView: MKMapView!
    
    var labelImageTitle: UILabel!
    var imageViewPet: UIImageView!
    var buttonSelectImage: UIButton!
    
    var buttonSubmit: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupScrollView()
        setupNameSection()
        setupDescriptionSection()
        setupPricingSection()
        setupCalendarSection()
        setupTimeIntervalsSection()
        setupLocationSection()
        setupImageSection()
        setupButtonSubmit()
        
        initConstraints()
    }
    
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
    
    func setupDescriptionSection(){
        labelDescriptionTitle = UILabel()
        labelDescriptionTitle.text = "Pet Description:"
        labelDescriptionTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelDescriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelDescriptionTitle)
        
        textViewDescription = UITextView()
        textViewDescription.text = "Enter pet description (breed, age, temperament, etc.)"
        textViewDescription.font = UIFont.systemFont(ofSize: 16)
        textViewDescription.layer.borderWidth = 1.0
        textViewDescription.layer.borderColor = UIColor.systemGray4.cgColor
        textViewDescription.layer.cornerRadius = 8
        textViewDescription.textColor = .lightGray
        textViewDescription.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textViewDescription)
    }
    
    func setupPricingSection(){
        labelPricingTitle = UILabel()
        labelPricingTitle.text = "Pricing:"
        labelPricingTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelPricingTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelPricingTitle)
        
        textFieldPricing = UITextField()
        textFieldPricing.placeholder = "Enter price (e.g., $100, Free)"
        textFieldPricing.borderStyle = .roundedRect
        textFieldPricing.keyboardType = .numbersAndPunctuation
        textFieldPricing.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textFieldPricing)
    }
    
    func setupCalendarSection(){
        labelCalendarTitle = UILabel()
        labelCalendarTitle.text = "Select Available Dates:"
        labelCalendarTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelCalendarTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelCalendarTitle)
        
        calendarView = UIDatePicker()
        calendarView.datePickerMode = .date
        calendarView.preferredDatePickerStyle = .inline
        calendarView.minimumDate = Date()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(calendarView)
    }
    
    func setupTimeIntervalsSection(){
        labelTimeIntervalsTitle = UILabel()
        labelTimeIntervalsTitle.text = "Select Available Time Intervals (1 hour each):"
        labelTimeIntervalsTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelTimeIntervalsTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelTimeIntervalsTitle)
        
        timeIntervalStackView = UIStackView()
        timeIntervalStackView.axis = .vertical
        timeIntervalStackView.spacing = 8
        timeIntervalStackView.distribution = .fillEqually
        timeIntervalStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeIntervalStackView)
        
        let timeIntervals = ["9:00 AM - 10:00 AM", "10:00 AM - 11:00 AM", "11:00 AM - 12:00 PM",
                           "1:00 PM - 2:00 PM", "2:00 PM - 3:00 PM", "3:00 PM - 4:00 PM",
                           "4:00 PM - 5:00 PM", "5:00 PM - 6:00 PM"]
        
        for interval in timeIntervals {
            let button = UIButton(type: .system)
            button.setTitle(interval, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.backgroundColor = .systemGray6
            button.setTitleColor(.systemBlue, for: .normal)
            button.layer.cornerRadius = 8
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemGray4.cgColor
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
            timeIntervalStackView.addArrangedSubview(button)
            timeIntervalButtons.append(button)
        }
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
        let span = MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100) // Valid world view
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
        imageViewPet.layer.cornerRadius = 12 // Square with rounded corners
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
    
    func setupButtonSubmit(){
        buttonSubmit = UIButton(type: .system)
        buttonSubmit.setTitle("Create Pet Listing", for: .normal)
        buttonSubmit.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        buttonSubmit.backgroundColor = .systemGreen
        buttonSubmit.setTitleColor(.white, for: .normal)
        buttonSubmit.layer.cornerRadius = 8
        buttonSubmit.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonSubmit)
    }
    
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
                    
            // Name section constraints - NOW STARTING FROM CONTENT VIEW TOP
            labelNameTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            labelNameTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelNameTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            textFieldName.topAnchor.constraint(equalTo: labelNameTitle.bottomAnchor, constant: 8),
            textFieldName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textFieldName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            textFieldName.heightAnchor.constraint(equalToConstant: 44),
            
            // Description section constraints
            labelDescriptionTitle.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            labelDescriptionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelDescriptionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            textViewDescription.topAnchor.constraint(equalTo: labelDescriptionTitle.bottomAnchor, constant: 8),
            textViewDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textViewDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            textViewDescription.heightAnchor.constraint(equalToConstant: 120),
            
            // Pricing section constraints
            labelPricingTitle.topAnchor.constraint(equalTo: textViewDescription.bottomAnchor, constant: 16),
            labelPricingTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelPricingTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            textFieldPricing.topAnchor.constraint(equalTo: labelPricingTitle.bottomAnchor, constant: 8),
            textFieldPricing.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textFieldPricing.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            textFieldPricing.heightAnchor.constraint(equalToConstant: 44),
            
            // Calendar section constraints
            labelCalendarTitle.topAnchor.constraint(equalTo: textFieldPricing.bottomAnchor, constant: 16),
            labelCalendarTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelCalendarTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            calendarView.topAnchor.constraint(equalTo: labelCalendarTitle.bottomAnchor, constant: 8),
            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            // Time intervals section constraints
            labelTimeIntervalsTitle.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 16),
            labelTimeIntervalsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelTimeIntervalsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            timeIntervalStackView.topAnchor.constraint(equalTo: labelTimeIntervalsTitle.bottomAnchor, constant: 8),
            timeIntervalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            timeIntervalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            timeIntervalStackView.heightAnchor.constraint(equalToConstant: 360), // 8 buttons * 44 height + 8*7 spacing
            
            // Location section constraints
            labelLocationTitle.topAnchor.constraint(equalTo: timeIntervalStackView.bottomAnchor, constant: 16),
            labelLocationTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelLocationTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            textFieldLocation.topAnchor.constraint(equalTo: labelLocationTitle.bottomAnchor, constant: 8),
            textFieldLocation.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textFieldLocation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            textFieldLocation.heightAnchor.constraint(equalToConstant: 44),
            
            // Calibrate button constraints
            buttonCalibrate.topAnchor.constraint(equalTo: textFieldLocation.bottomAnchor, constant: 16),
            buttonCalibrate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            buttonCalibrate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            buttonCalibrate.heightAnchor.constraint(equalToConstant: 44),
            
            // Map view constraints - ALWAYS VISIBLE
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
            imageViewPet.heightAnchor.constraint(equalToConstant: 150), // Square image
            
            buttonSelectImage.topAnchor.constraint(equalTo: imageViewPet.bottomAnchor, constant: 16),
            buttonSelectImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonSelectImage.widthAnchor.constraint(equalToConstant: 150),
            buttonSelectImage.heightAnchor.constraint(equalToConstant: 44),
            
            // Submit button constraints
            buttonSubmit.topAnchor.constraint(equalTo: buttonSelectImage.bottomAnchor, constant: 32),
            buttonSubmit.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonSubmit.widthAnchor.constraint(equalToConstant: 200),
            buttonSubmit.heightAnchor.constraint(equalToConstant: 50),
            buttonSubmit.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
