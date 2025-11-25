//
//  PetListing.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/13/25.
//

import UIKit
import CoreLocation

struct PetListing {
    let name: String
    let petImage: UIImage?
    let description: String
    let pricing: String
    let availableDates: [Date]
    let availableTimeIntervals: [String]
    let locationAddress: String
    let coordinates: CLLocationCoordinate2D? // Make this optional
    
    // You can also add a convenience initializer if needed
    init(name: String, petImage: UIImage?, description: String, pricing: String,
         availableDates: [Date], availableTimeIntervals: [String],
         locationAddress: String, coordinates: CLLocationCoordinate2D?) {
        self.name = name
        self.petImage = petImage
        self.description = description
        self.pricing = pricing
        self.availableDates = availableDates
        self.availableTimeIntervals = availableTimeIntervals
        self.locationAddress = locationAddress
        self.coordinates = coordinates
    }
}
