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
    
    // Pet Selection Section
    var labelPetSelectionTitle: UILabel!
    var petDropdownButton: UIButton!
    var petDropdownTableView: UITableView!
    var isDropdownExpanded = false
    
    // Price Section
    var labelPricingTitle: UILabel!
    var textFieldPricing: UITextField!
    
    // Availability Calendar Section
    var labelCalendarTitle: UILabel!
    var calendarView: UIDatePicker!
    
    // Time Intervals Section
    var labelTimeIntervalsTitle: UILabel!
    var timeIntervalStackView: UIStackView!
    var timeIntervalButtons: [UIButton] = []
    
    var buttonSubmit: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupScrollView()
        setupPetSelectionSection()
        setupPricingSection()
        setupCalendarSection()
        setupTimeIntervalsSection()
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
    
    func setupPetSelectionSection() {
        labelPetSelectionTitle = UILabel()
        labelPetSelectionTitle.text = "Select Pet:"
        labelPetSelectionTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelPetSelectionTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelPetSelectionTitle)
        
        petDropdownButton = UIButton(type: .system)
        petDropdownButton.setTitle("Select a pet", for: .normal)
        petDropdownButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        petDropdownButton.backgroundColor = .systemGray6
        petDropdownButton.setTitleColor(.systemBlue, for: .normal)
        petDropdownButton.layer.cornerRadius = 8
        petDropdownButton.layer.borderWidth = 1
        petDropdownButton.layer.borderColor = UIColor.systemGray4.cgColor
        petDropdownButton.contentHorizontalAlignment = .left
        petDropdownButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        petDropdownButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Add dropdown arrow
        let dropdownArrow = UIImageView(image: UIImage(systemName: "chevron.down"))
        dropdownArrow.tintColor = .systemGray
        dropdownArrow.translatesAutoresizingMaskIntoConstraints = false
        petDropdownButton.addSubview(dropdownArrow)
        
        NSLayoutConstraint.activate([
            dropdownArrow.trailingAnchor.constraint(equalTo: petDropdownButton.trailingAnchor, constant: -12),
            dropdownArrow.centerYAnchor.constraint(equalTo: petDropdownButton.centerYAnchor)
        ])
        
        contentView.addSubview(petDropdownButton)
        
        petDropdownTableView = UITableView()
        petDropdownTableView.isHidden = true
        petDropdownTableView.layer.cornerRadius = 8
        petDropdownTableView.layer.borderWidth = 1
        petDropdownTableView.layer.borderColor = UIColor.systemGray4.cgColor
        petDropdownTableView.register(UITableViewCell.self, forCellReuseIdentifier: "petCell")
        petDropdownTableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(petDropdownTableView)
    }
    
    func setupPricingSection(){
        labelPricingTitle = UILabel()
        labelPricingTitle.text = "Price:"
        labelPricingTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelPricingTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelPricingTitle)
        
        textFieldPricing = UITextField()
        textFieldPricing.placeholder = "Enter price (e.g., $100)"
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
    
    func setupButtonSubmit(){
        buttonSubmit = UIButton(type: .system)
        buttonSubmit.setTitle("Create Listing", for: .normal)
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
            
            // Pet Selection section constraints
            labelPetSelectionTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            labelPetSelectionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelPetSelectionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            petDropdownButton.topAnchor.constraint(equalTo: labelPetSelectionTitle.bottomAnchor, constant: 8),
            petDropdownButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            petDropdownButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            petDropdownButton.heightAnchor.constraint(equalToConstant: 44),
            
            petDropdownTableView.topAnchor.constraint(equalTo: petDropdownButton.bottomAnchor, constant: 4),
            petDropdownTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            petDropdownTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            petDropdownTableView.heightAnchor.constraint(equalToConstant: 150),
            
            // Pricing section constraints
            labelPricingTitle.topAnchor.constraint(equalTo: petDropdownButton.bottomAnchor, constant: 24),
            labelPricingTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelPricingTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            textFieldPricing.topAnchor.constraint(equalTo: labelPricingTitle.bottomAnchor, constant: 8),
            textFieldPricing.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textFieldPricing.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            textFieldPricing.heightAnchor.constraint(equalToConstant: 44),
            
            // Calendar section constraints
            labelCalendarTitle.topAnchor.constraint(equalTo: textFieldPricing.bottomAnchor, constant: 24),
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
            
            // Submit button constraints
            buttonSubmit.topAnchor.constraint(equalTo: timeIntervalStackView.bottomAnchor, constant: 32),
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
