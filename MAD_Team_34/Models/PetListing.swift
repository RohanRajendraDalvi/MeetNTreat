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
    let coordinates: CLLocationCoordinate2D
    
}
