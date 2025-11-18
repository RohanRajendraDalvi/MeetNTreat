//
//  HomeScreenView.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/13/25.
//

import UIKit

class HomeScreenView: UIView {

    var titleLabel: UILabel!
    var filterButton: UIButton!
    var availabilityFilterButton: UIButton!
    var filterDropdownView: UIView!
    var highToLowButton: UIButton!
    var lowToHighButton: UIButton!
    var availabilityDropdownView: UIView!
    var calendarView: UIDatePicker!
    var applyAvailabilityButton: UIButton!
    var clearAvailabilityButton: UIButton!
    var tableView: UITableView!
    var bottomNavBar: UIView!
    var homeButton: UIButton!
    var createListingButton: UIButton!
    var profileButton: UIButton!
    
    var isFilterDropdownVisible = false
    var isAvailabilityDropdownVisible = false
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupTitleLabel()
        setupFilterButtons()
        setupFilterDropdown()
        setupAvailabilityDropdown()
        setupTableView()
        setupBottomNavBar()
        initConstraints()
        hideFilterDropdown()
        hideAvailabilityDropdown()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Home Screen"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    private func setupFilterButtons() {
        // Price Filter Button
        filterButton = UIButton(type: .system)
        filterButton.setTitle("Sort by: Price", for: .normal)
        filterButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        filterButton.backgroundColor = .systemGray6
        filterButton.setTitleColor(.label, for: .normal)
        filterButton.layer.cornerRadius = 8
        filterButton.layer.borderWidth = 1
        filterButton.layer.borderColor = UIColor.systemGray4.cgColor
        filterButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(filterButton)
        
        availabilityFilterButton = UIButton(type: .system)
        availabilityFilterButton.setTitle("Filter by Availability", for: .normal)
        availabilityFilterButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        availabilityFilterButton.backgroundColor = .systemGray6
        availabilityFilterButton.setTitleColor(.label, for: .normal)
        availabilityFilterButton.layer.cornerRadius = 8
        availabilityFilterButton.layer.borderWidth = 1
        availabilityFilterButton.layer.borderColor = UIColor.systemGray4.cgColor
        availabilityFilterButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        availabilityFilterButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(availabilityFilterButton)
    }
    
    private func setupFilterDropdown() {
        filterDropdownView = UIView()
        filterDropdownView.backgroundColor = .systemBackground
        filterDropdownView.layer.cornerRadius = 8
        filterDropdownView.layer.borderWidth = 1
        filterDropdownView.layer.borderColor = UIColor.systemGray4.cgColor
        filterDropdownView.layer.shadowColor = UIColor.black.cgColor
        filterDropdownView.layer.shadowOffset = CGSize(width: 0, height: 2)
        filterDropdownView.layer.shadowOpacity = 0.2
        filterDropdownView.layer.shadowRadius = 8
        filterDropdownView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(filterDropdownView)
        
        highToLowButton = UIButton(type: .system)
        highToLowButton.setTitle("Price: High to Low", for: .normal)
        highToLowButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        highToLowButton.contentHorizontalAlignment = .left
        highToLowButton.setTitleColor(.label, for: .normal)
        highToLowButton.backgroundColor = .clear
        highToLowButton.translatesAutoresizingMaskIntoConstraints = false
        filterDropdownView.addSubview(highToLowButton)
        
        lowToHighButton = UIButton(type: .system)
        lowToHighButton.setTitle("Price: Low to High", for: .normal)
        lowToHighButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        lowToHighButton.contentHorizontalAlignment = .left
        lowToHighButton.setTitleColor(.label, for: .normal)
        lowToHighButton.backgroundColor = .clear
        lowToHighButton.translatesAutoresizingMaskIntoConstraints = false
        filterDropdownView.addSubview(lowToHighButton)
        
        let separator = UIView()
        separator.backgroundColor = .systemGray4
        separator.translatesAutoresizingMaskIntoConstraints = false
        filterDropdownView.addSubview(separator)
        
        NSLayoutConstraint.activate([
            highToLowButton.topAnchor.constraint(equalTo: filterDropdownView.topAnchor, constant: 8),
            highToLowButton.leadingAnchor.constraint(equalTo: filterDropdownView.leadingAnchor, constant: 12),
            highToLowButton.trailingAnchor.constraint(equalTo: filterDropdownView.trailingAnchor, constant: -12),
            highToLowButton.heightAnchor.constraint(equalToConstant: 36),
            
            separator.topAnchor.constraint(equalTo: highToLowButton.bottomAnchor, constant: 4),
            separator.leadingAnchor.constraint(equalTo: filterDropdownView.leadingAnchor, constant: 8),
            separator.trailingAnchor.constraint(equalTo: filterDropdownView.trailingAnchor, constant: -8),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            lowToHighButton.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 4),
            lowToHighButton.leadingAnchor.constraint(equalTo: filterDropdownView.leadingAnchor, constant: 12),
            lowToHighButton.trailingAnchor.constraint(equalTo: filterDropdownView.trailingAnchor, constant: -12),
            lowToHighButton.heightAnchor.constraint(equalToConstant: 36),
            lowToHighButton.bottomAnchor.constraint(equalTo: filterDropdownView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupAvailabilityDropdown() {
        availabilityDropdownView = UIView()
        availabilityDropdownView.backgroundColor = .systemBackground
        availabilityDropdownView.layer.cornerRadius = 8
        availabilityDropdownView.layer.borderWidth = 1
        availabilityDropdownView.layer.borderColor = UIColor.systemGray4.cgColor
        availabilityDropdownView.layer.shadowColor = UIColor.black.cgColor
        availabilityDropdownView.layer.shadowOffset = CGSize(width: 0, height: 2)
        availabilityDropdownView.layer.shadowOpacity = 0.2
        availabilityDropdownView.layer.shadowRadius = 8
        availabilityDropdownView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(availabilityDropdownView)
        
        calendarView = UIDatePicker()
        calendarView.datePickerMode = .date
        calendarView.preferredDatePickerStyle = .inline
        calendarView.minimumDate = Date()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        availabilityDropdownView.addSubview(calendarView)
        
        applyAvailabilityButton = UIButton(type: .system)
        applyAvailabilityButton.setTitle("Apply Filter", for: .normal)
        applyAvailabilityButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        applyAvailabilityButton.backgroundColor = .systemBlue
        applyAvailabilityButton.setTitleColor(.white, for: .normal)
        applyAvailabilityButton.layer.cornerRadius = 8
        applyAvailabilityButton.translatesAutoresizingMaskIntoConstraints = false
        availabilityDropdownView.addSubview(applyAvailabilityButton)
        
        clearAvailabilityButton = UIButton(type: .system)
        clearAvailabilityButton.setTitle("Clear", for: .normal)
        clearAvailabilityButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        clearAvailabilityButton.backgroundColor = .systemGray5
        clearAvailabilityButton.setTitleColor(.label, for: .normal)
        clearAvailabilityButton.layer.cornerRadius = 8
        clearAvailabilityButton.translatesAutoresizingMaskIntoConstraints = false
        availabilityDropdownView.addSubview(clearAvailabilityButton)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: availabilityDropdownView.topAnchor, constant: 12),
            calendarView.leadingAnchor.constraint(equalTo: availabilityDropdownView.leadingAnchor, constant: 8),
            calendarView.trailingAnchor.constraint(equalTo: availabilityDropdownView.trailingAnchor, constant: -8),
            calendarView.heightAnchor.constraint(equalToConstant: 330), // Proper height for inline calendar
            
            applyAvailabilityButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 12),
            applyAvailabilityButton.leadingAnchor.constraint(equalTo: availabilityDropdownView.leadingAnchor, constant: 12),
            applyAvailabilityButton.trailingAnchor.constraint(equalTo: availabilityDropdownView.trailingAnchor, constant: -12),
            applyAvailabilityButton.heightAnchor.constraint(equalToConstant: 44),
            
            clearAvailabilityButton.topAnchor.constraint(equalTo: applyAvailabilityButton.bottomAnchor, constant: 8),
            clearAvailabilityButton.leadingAnchor.constraint(equalTo: availabilityDropdownView.leadingAnchor, constant: 12),
            clearAvailabilityButton.trailingAnchor.constraint(equalTo: availabilityDropdownView.trailingAnchor, constant: -12),
            clearAvailabilityButton.heightAnchor.constraint(equalToConstant: 44),
            clearAvailabilityButton.bottomAnchor.constraint(equalTo: availabilityDropdownView.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PetListingCell.self, forCellReuseIdentifier: "PetListingCell")
        self.addSubview(tableView)
    }
    
    private func setupBottomNavBar() {
        bottomNavBar = UIView()
        bottomNavBar.backgroundColor = .systemBackground
        bottomNavBar.layer.shadowColor = UIColor.black.cgColor
        bottomNavBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomNavBar.layer.shadowOpacity = 0.1
        bottomNavBar.layer.shadowRadius = 4
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomNavBar)
        
        homeButton = UIButton(type: .system)
        homeButton.setImage(UIImage(systemName: "house.fill"), for: .normal)
        homeButton.tintColor = .systemBlue
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.addSubview(homeButton)
        
        createListingButton = UIButton(type: .system)
        createListingButton.setTitle("Create Listing", for: .normal)
        createListingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        createListingButton.backgroundColor = .systemBlue
        createListingButton.setTitleColor(.white, for: .normal)
        createListingButton.layer.cornerRadius = 25
        createListingButton.layer.shadowColor = UIColor.systemBlue.cgColor
        createListingButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        createListingButton.layer.shadowOpacity = 0.3
        createListingButton.layer.shadowRadius = 8
        createListingButton.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.addSubview(createListingButton)
        
        profileButton = UIButton(type: .system)
        profileButton.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        profileButton.tintColor = .systemGray
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.addSubview(profileButton)
    }
    
    func showFilterDropdown() {
        isFilterDropdownVisible = true
        filterDropdownView.isHidden = false
        filterDropdownView.alpha = 0
        filterDropdownView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3,
                      delay: 0,
                      usingSpringWithDamping: 0.7,
                      initialSpringVelocity: 0.5,
                      options: .curveEaseInOut) {
            self.filterDropdownView.alpha = 1
            self.filterDropdownView.transform = CGAffineTransform.identity
        }
        
        self.bringSubviewToFront(filterDropdownView)
    }
    
    func hideFilterDropdown() {
        isFilterDropdownVisible = false
        UIView.animate(withDuration: 0.2, animations: {
            self.filterDropdownView.alpha = 0
            self.filterDropdownView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            self.filterDropdownView.isHidden = true
            self.filterDropdownView.transform = CGAffineTransform.identity
        }
    }
    
    func toggleFilterDropdown() {
        if isFilterDropdownVisible {
            hideFilterDropdown()
        } else {
            hideAvailabilityDropdown()
            showFilterDropdown()
        }
    }
    
    func showAvailabilityDropdown() {
        isAvailabilityDropdownVisible = true
        availabilityDropdownView.isHidden = false
        availabilityDropdownView.alpha = 0
        availabilityDropdownView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3,
                      delay: 0,
                      usingSpringWithDamping: 0.7,
                      initialSpringVelocity: 0.5,
                      options: .curveEaseInOut) {
            self.availabilityDropdownView.alpha = 1
            self.availabilityDropdownView.transform = CGAffineTransform.identity
        }
        
        self.bringSubviewToFront(availabilityDropdownView)
    }
    
    func hideAvailabilityDropdown() {
        isAvailabilityDropdownVisible = false
        UIView.animate(withDuration: 0.2, animations: {
            self.availabilityDropdownView.alpha = 0
            self.availabilityDropdownView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            self.availabilityDropdownView.isHidden = true
            self.availabilityDropdownView.transform = CGAffineTransform.identity
        }
    }
    
    func toggleAvailabilityDropdown() {
        if isAvailabilityDropdownVisible {
            hideAvailabilityDropdown()
        } else {
            hideFilterDropdown()
            showAvailabilityDropdown()
        }
    }

    private func initConstraints() {
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Filter Buttons
            filterButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            filterButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            filterButton.heightAnchor.constraint(equalToConstant: 36),
            
            availabilityFilterButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            availabilityFilterButton.leadingAnchor.constraint(equalTo: filterButton.trailingAnchor, constant: 12),
            availabilityFilterButton.heightAnchor.constraint(equalToConstant: 36),
            
            // Filter Dropdown
            filterDropdownView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 8),
            filterDropdownView.leadingAnchor.constraint(equalTo: filterButton.leadingAnchor),
            filterDropdownView.widthAnchor.constraint(equalToConstant: 200),
            filterDropdownView.heightAnchor.constraint(equalToConstant: 90),
            
            // Availability Dropdown - FIXED to fit screen properly
            availabilityDropdownView.topAnchor.constraint(equalTo: availabilityFilterButton.bottomAnchor, constant: 8),
            availabilityDropdownView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            availabilityDropdownView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            availabilityDropdownView.heightAnchor.constraint(equalToConstant: 450), // Proper height for inline calendar + buttons
            
            // Table View - Make it adjust when dropdowns are visible
            tableView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Bottom Navigation Bar
            bottomNavBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomNavBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomNavBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomNavBar.heightAnchor.constraint(equalToConstant: 80),
            
            // Home Button
            homeButton.leadingAnchor.constraint(equalTo: bottomNavBar.leadingAnchor, constant: 32),
            homeButton.centerYAnchor.constraint(equalTo: bottomNavBar.centerYAnchor),
            homeButton.widthAnchor.constraint(equalToConstant: 44),
            homeButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Create Listing Button
            createListingButton.centerXAnchor.constraint(equalTo: bottomNavBar.centerXAnchor),
            createListingButton.centerYAnchor.constraint(equalTo: bottomNavBar.centerYAnchor),
            createListingButton.widthAnchor.constraint(equalToConstant: 150),
            createListingButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Profile Button
            profileButton.trailingAnchor.constraint(equalTo: bottomNavBar.trailingAnchor, constant: -32),
            profileButton.centerYAnchor.constraint(equalTo: bottomNavBar.centerYAnchor),
            profileButton.widthAnchor.constraint(equalToConstant: 44),
            profileButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

class PetListingCell: UITableViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let petImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .systemGray6
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        sv.alignment = .leading
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(petImageView)
        containerView.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            // Container View
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Pet Image
            petImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            petImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            petImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            petImageView.widthAnchor.constraint(equalTo: petImageView.heightAnchor),
            petImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Stack View
            stackView.leadingAnchor.constraint(equalTo: petImageView.trailingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func configure(with pet: PetListing) {
        nameLabel.text = pet.name
        priceLabel.text = "$\(pet.pricing)"
        petImageView.image = pet.petImage ?? UIImage(systemName: "photo")
        petImageView.tintColor = pet.petImage == nil ? .systemGray3 : .clear
    }
}
