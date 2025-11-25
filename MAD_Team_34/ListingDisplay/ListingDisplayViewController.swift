//
//  ListingDisplayViewController.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/12/25.
//

import UIKit

class ListingDisplayViewController: UIViewController {

    // Add this property to fix the error
    var petListing: PetListing?
    
    var listingDisplayView = ListingDisplayView()
    
    override func loadView() {
        view = listingDisplayView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Listing Details"
        
        // You can add basic setup here later
        if let listing = petListing {
            // Set up your view with the pet listing data
            print("Loaded pet listing: \(listing.name)")
        }
    }
}
