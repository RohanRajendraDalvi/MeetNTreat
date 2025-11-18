//
//  DisplayView.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/12/25.
//

import UIKit
import MapKit

class ListingDisplayView: UIView {

    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var imageViewPet: UIImageView!
    var labelName: UILabel!
    var labelPricing: UILabel!
    var labelDescription: UILabel!
    var labelLocation: UILabel!
    
    var labelLocationTitle: UILabel!
    var mapView: MKMapView!
    
    var labelCalendarTitle: UILabel!
    var calendarView: UIDatePicker!
    
    var labelTimeIntervalsTitle: UILabel!
    var timeIntervalsStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupScrollView()
        setupImageViewPet()
        setupLabelName()
        setupLabelPricing()
        setupLabelDescription()
        setupLabelLocation()
        setupMapSection()
        setupCalendarSection()
        setupTimeIntervalsSection()
        
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
    
    func setupImageViewPet(){
        imageViewPet = UIImageView()
        imageViewPet.contentMode = .scaleAspectFill
        imageViewPet.clipsToBounds = true
        imageViewPet.layer.cornerRadius = 75
        imageViewPet.layer.borderWidth = 3
        imageViewPet.layer.borderColor = UIColor.systemBlue.cgColor
        imageViewPet.backgroundColor = .systemGray6
        imageViewPet.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageViewPet)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 20)
        labelName.textAlignment = .center
        labelName.numberOfLines = 0
        labelName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelName)
    }
    
    func setupLabelPricing(){
        labelPricing = UILabel()
        labelPricing.font = UIFont.boldSystemFont(ofSize: 18)
        labelPricing.textAlignment = .center
        labelPricing.textColor = .black
        labelPricing.numberOfLines = 0
        labelPricing.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelPricing)
    }
    
    func setupLabelDescription(){
        labelDescription = UILabel()
        labelDescription.font = UIFont.systemFont(ofSize: 16)
        labelDescription.textAlignment = .center
        labelDescription.numberOfLines = 0
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelDescription)
    }
    
    func setupLabelLocation(){
        labelLocation = UILabel()
        labelLocation.font = UIFont.systemFont(ofSize: 16)
        labelLocation.textAlignment = .center
        labelLocation.numberOfLines = 0
        labelLocation.textColor = .systemGray
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelLocation)
    }
    
    func setupMapSection(){
        labelLocationTitle = UILabel()
        labelLocationTitle.text = "Location Map (1-mile radius):"
        labelLocationTitle.font = UIFont.boldSystemFont(ofSize: 18)
        labelLocationTitle.textAlignment = .center
        labelLocationTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelLocationTitle)
        
        mapView = MKMapView()
        mapView.layer.cornerRadius = 8
        mapView.layer.borderWidth = 1.0
        mapView.layer.borderColor = UIColor.systemGray4.cgColor
        mapView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapView)
    }
    
    func setupCalendarSection(){
        labelCalendarTitle = UILabel()
        labelCalendarTitle.text = "Select a Date to View Available Times:"
        labelCalendarTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelCalendarTitle.textAlignment = .center
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
        labelTimeIntervalsTitle.text = "Available Time Intervals:"
        labelTimeIntervalsTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelTimeIntervalsTitle.textAlignment = .center
        labelTimeIntervalsTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelTimeIntervalsTitle)
        
        timeIntervalsStackView = UIStackView()
        timeIntervalsStackView.axis = .vertical
        timeIntervalsStackView.spacing = 8
        timeIntervalsStackView.distribution = .fillEqually
        timeIntervalsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeIntervalsStackView)
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
            
            // Pet Image constraints - CENTERED AT THE TOP
            imageViewPet.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            imageViewPet.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageViewPet.widthAnchor.constraint(equalToConstant: 150),
            imageViewPet.heightAnchor.constraint(equalToConstant: 150),
            
            // Name constraints
            labelName.topAnchor.constraint(equalTo: imageViewPet.bottomAnchor, constant: 24),
            labelName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            // Pricing constraints - BELOW NAME
            labelPricing.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            labelPricing.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelPricing.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            // Description constraints
            labelDescription.topAnchor.constraint(equalTo: labelPricing.bottomAnchor, constant: 16),
            labelDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            // Location constraints
            labelLocation.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 16),
            labelLocation.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelLocation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            // Map section constraints - ABOVE CALENDAR
            labelLocationTitle.topAnchor.constraint(equalTo: labelLocation.bottomAnchor, constant: 24),
            labelLocationTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelLocationTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            mapView.topAnchor.constraint(equalTo: labelLocationTitle.bottomAnchor, constant: 16),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            mapView.heightAnchor.constraint(equalToConstant: 200),
            
            // Calendar section constraints
            labelCalendarTitle.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 24),
            labelCalendarTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelCalendarTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            calendarView.topAnchor.constraint(equalTo: labelCalendarTitle.bottomAnchor, constant: 8),
            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            // Time intervals section constraints
            labelTimeIntervalsTitle.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 16),
            labelTimeIntervalsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelTimeIntervalsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            timeIntervalsStackView.topAnchor.constraint(equalTo: labelTimeIntervalsTitle.bottomAnchor, constant: 8),
            timeIntervalsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            timeIntervalsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            timeIntervalsStackView.heightAnchor.constraint(equalToConstant: 180), // Reduced height for sleek look
            timeIntervalsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
