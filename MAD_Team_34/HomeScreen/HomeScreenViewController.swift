//
//  HomeScreenViewController.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/13/25.
//

import UIKit

class HomeScreenViewController: UIViewController {

    let homeScreenView = HomeScreenView()

    var petListings: [PetListing] = []
    var filteredPetListings: [PetListing] = []
    var currentSortOption: SortOption = .none
    var selectedAvailabilityDate: Date?
    
    enum SortOption {
        case none
        case highToLow
        case lowToHigh
    }
    
    override func loadView() {
        view = homeScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupButtonActions()
        setupFilterActions()
        setupAvailabilityActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        refreshPetListings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        homeScreenView.hideFilterDropdown()
        homeScreenView.hideAvailabilityDropdown()
    }

    private func setupTableView() {
        homeScreenView.tableView.delegate = self
        homeScreenView.tableView.dataSource = self
    }
    
    private func setupButtonActions() {
        homeScreenView.createListingButton.addTarget(self, action: #selector(createListingTapped), for: .touchUpInside)
        homeScreenView.profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        homeScreenView.homeButton.addTarget(self, action: #selector(homeTapped), for: .touchUpInside)
        homeScreenView.filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        homeScreenView.availabilityFilterButton.addTarget(self, action: #selector(availabilityFilterButtonTapped), for: .touchUpInside)
    }
    
    private func setupFilterActions() {
        homeScreenView.highToLowButton.addTarget(self, action: #selector(highToLowTapped), for: .touchUpInside)
        homeScreenView.lowToHighButton.addTarget(self, action: #selector(lowToHighTapped), for: .touchUpInside)
    }
    
    private func setupAvailabilityActions() {
        homeScreenView.applyAvailabilityButton.addTarget(self, action: #selector(applyAvailabilityTapped), for: .touchUpInside)
        homeScreenView.clearAvailabilityButton.addTarget(self, action: #selector(clearAvailabilityTapped), for: .touchUpInside)
    }

    private func refreshPetListings() {
        applyCurrentFilters()
        homeScreenView.tableView.reloadData()
        
        if filteredPetListings.isEmpty {
            setupEmptyState()
        } else {
            removeEmptyState()
        }
    }
    
    private func applyCurrentFilters() {
        if let selectedDate = selectedAvailabilityDate {
            filteredPetListings = petListings.filter { pet in
                return isPetAvailableOnDate(pet, date: selectedDate)
            }
        } else {
            filteredPetListings = petListings
        }
        
        applyCurrentSort()
    }
    
    private func applyCurrentSort() {
        switch currentSortOption {
        case .none:
            break
        case .highToLow:
            filteredPetListings.sort { (first, second) -> Bool in
                let firstPrice = Int(first.pricing) ?? 0
                let secondPrice = Int(second.pricing) ?? 0
                return firstPrice > secondPrice
            }
        case .lowToHigh:
            filteredPetListings.sort { (first, second) -> Bool in
                let firstPrice = Int(first.pricing) ?? 0
                let secondPrice = Int(second.pricing) ?? 0
                return firstPrice < secondPrice
            }
        }
    }
    
    private func isPetAvailableOnDate(_ pet: PetListing, date: Date) -> Bool {
        let calendar = Calendar.current
        return pet.availableDates.contains { availableDate in
            calendar.isDate(availableDate, inSameDayAs: date)
        }
    }
    
    private func setupEmptyState() {
        let emptyLabel = UILabel()
        
        if petListings.isEmpty {
            emptyLabel.text = "No Pet Listings Yet\nTap 'Create Listing' to add your first pet!"
        } else if selectedAvailabilityDate != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let dateString = dateFormatter.string(from: selectedAvailabilityDate!)
            emptyLabel.text = "No pets available on \(dateString)\nTry selecting a different date"
        } else {
            emptyLabel.text = "No Pet Listings Yet\nTap 'Create Listing' to add your first pet!"
        }
        
        emptyLabel.textAlignment = .center
        emptyLabel.numberOfLines = 0
        emptyLabel.textColor = .systemGray
        emptyLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        emptyLabel.tag = 100
        
        homeScreenView.tableView.backgroundView = emptyLabel
    }
    
    private func removeEmptyState() {
        homeScreenView.tableView.backgroundView = nil
    }
    
    @objc private func createListingTapped() {
        let createListingVC = ListingCreationViewController()
        createListingVC.onListingCreated = { [weak self] newListing in
            self?.petListings.append(newListing)
            self?.refreshPetListings()
            self?.removeEmptyState()
        }
        navigationController?.pushViewController(createListingVC, animated: true)
    }
    
    @objc private func profileTapped() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc private func homeTapped() {
        homeScreenView.hideFilterDropdown()
        homeScreenView.hideAvailabilityDropdown()
        if !filteredPetListings.isEmpty {
            let indexPath = IndexPath(row: 0, section: 0)
            homeScreenView.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    @objc private func filterButtonTapped() {
        homeScreenView.toggleFilterDropdown()
    }
    
    @objc private func availabilityFilterButtonTapped() {
        homeScreenView.toggleAvailabilityDropdown()
    }
    
    @objc private func highToLowTapped() {
        currentSortOption = .highToLow
        homeScreenView.filterButton.setTitle("Sort by: High to Low", for: .normal)
        homeScreenView.hideFilterDropdown()
        refreshPetListings()
    }
    
    @objc private func lowToHighTapped() {
        currentSortOption = .lowToHigh
        homeScreenView.filterButton.setTitle("Sort by: Low to High", for: .normal)
        homeScreenView.hideFilterDropdown()
        refreshPetListings()
    }
    
    @objc private func applyAvailabilityTapped() {
        selectedAvailabilityDate = homeScreenView.calendarView.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: selectedAvailabilityDate!)
        homeScreenView.availabilityFilterButton.setTitle("Available: \(dateString)", for: .normal)
        homeScreenView.hideAvailabilityDropdown()
        refreshPetListings()
    }
    
    @objc private func clearAvailabilityTapped() {
        selectedAvailabilityDate = nil
        homeScreenView.availabilityFilterButton.setTitle("Filter by Availability", for: .normal)
        homeScreenView.hideAvailabilityDropdown()
        refreshPetListings()
    }
}

extension HomeScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetListingCell", for: indexPath) as! PetListingCell
        let pet = filteredPetListings[indexPath.row]
        cell.configure(with: pet)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Fixed height for each row
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeScreenView.hideFilterDropdown()
        homeScreenView.hideAvailabilityDropdown()
        let pet = filteredPetListings[indexPath.row]
        let detailVC = ListingDisplayViewController()
        detailVC.petListing = pet
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
