//
//  ListingDisplayViewController.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/12/25.
//

import UIKit
import MapKit

class ListingDisplayViewController: UIViewController {

    let listingDisplayView = ListingDisplayView()
    
    var petListing: PetListing?
    
    override func loadView() {
        view = listingDisplayView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pet Listing Details"
        
        if let listing = petListing {
            if let petImage = listing.petImage {
                listingDisplayView.imageViewPet.image = petImage
                listingDisplayView.imageViewPet.backgroundColor = .clear
            } else {
                listingDisplayView.imageViewPet.image = UIImage(systemName: "photo")
                listingDisplayView.imageViewPet.tintColor = .systemGray3
            }
            
            listingDisplayView.labelName.text = "\(listing.name)"
            listingDisplayView.labelPricing.text = "$ \(listing.pricing)"
            listingDisplayView.labelDescription.text = "\(listing.description)"
//            listingDisplayView.labelLocation.text = "Address: \(listing.locationAddress)"
            setupMapWithLocation(listing.coordinates)
            
            setupCalendar()
            
            showAvailableTimeIntervals(for: Date())
        }
        
        listingDisplayView.mapView.delegate = self
    }
    
    func setupCalendar() {
        listingDisplayView.calendarView.addTarget(self, action: #selector(onDateSelected), for: .valueChanged)
        
        listingDisplayView.calendarView.minimumDate = Date()
        
        if let availableDates = petListing?.availableDates, !availableDates.isEmpty {
            if let firstAvailableDate = availableDates.first {
                listingDisplayView.calendarView.date = firstAvailableDate
                showAvailableTimeIntervals(for: firstAvailableDate)
            }
        }
    }
    
    @objc func onDateSelected() {
        let selectedDate = listingDisplayView.calendarView.date
        showAvailableTimeIntervals(for: selectedDate)
    }
    
    func showAvailableTimeIntervals(for date: Date) {
        listingDisplayView.timeIntervalsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let petListing = petListing else { return }
        
        let calendar = Calendar.current
        let isDateAvailable = petListing.availableDates.contains { availableDate in
            calendar.isDate(availableDate, inSameDayAs: date)
        }
        
        if isDateAvailable {
           
            for timeInterval in petListing.availableTimeIntervals {
                let timeLabel = UILabel()
                timeLabel.text = timeInterval
                timeLabel.font = UIFont.systemFont(ofSize: 14)
                timeLabel.textAlignment = .center
                timeLabel.backgroundColor = .systemGray6
                timeLabel.textColor = .systemBlue
                timeLabel.layer.cornerRadius = 6
                timeLabel.layer.borderWidth = 1
                timeLabel.layer.borderColor = UIColor.systemGray4.cgColor
                timeLabel.clipsToBounds = true
                timeLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
                
                listingDisplayView.timeIntervalsStackView.addArrangedSubview(timeLabel)
            }
            
            if petListing.availableTimeIntervals.isEmpty {
                let noTimesLabel = UILabel()
                noTimesLabel.text = "No time intervals available for this date"
                noTimesLabel.font = UIFont.systemFont(ofSize: 14)
                noTimesLabel.textAlignment = .center
                noTimesLabel.textColor = .systemGray
                noTimesLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
                
                listingDisplayView.timeIntervalsStackView.addArrangedSubview(noTimesLabel)
            }
        } else {
            let notAvailableLabel = UILabel()
            notAvailableLabel.text = "This date is not available for appointments"
            notAvailableLabel.font = UIFont.systemFont(ofSize: 14)
            notAvailableLabel.textAlignment = .center
            notAvailableLabel.textColor = .systemRed
            notAvailableLabel.backgroundColor = .systemRed.withAlphaComponent(0.1)
            notAvailableLabel.layer.cornerRadius = 6
            notAvailableLabel.clipsToBounds = true
            notAvailableLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
            
            listingDisplayView.timeIntervalsStackView.addArrangedSubview(notAvailableLabel)
        }
    }
    
    func setupMapWithLocation(_ location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 2000, longitudinalMeters: 2000)
        listingDisplayView.mapView.setRegion(region, animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = petListing?.name
        annotation.subtitle = "Pet Location"
        listingDisplayView.mapView.addAnnotation(annotation)
        
        let circle = MKCircle(center: location, radius: 1609.34)
        listingDisplayView.mapView.addOverlay(circle)
    }
}

extension ListingDisplayViewController: MKMapViewDelegate {
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let identifier = "petLocation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
