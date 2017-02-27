//
//  LocationServices.swift
//  LoChanger
//
//  Created by Nolan Lapham on 2/27/17.
//  Copyright © 2017 Nolan Lapham. All rights reserved.
//

import CoreLocation
import RxSwift

final class LocationService: NSObject, CLLocationManagerDelegate {
	
	// MARK: Variables
	
	private var locationManager = CLLocationManager()
  private(set) var location = Variable<CLLocation?>(nil)
  private(set) var geoLocation = Variable<String?>(nil)
	static let sharedInstance: LocationService = {
		return LocationService()
	}()

	// MARK: Init
	
	override init() {
		super.init()

		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = 500
	}
	
	// MARK: Authorization & Start Updating Location
	
	func startUpdatingLocation() {
		let authorizationStatus = CLLocationManager.authorizationStatus()
		if !(authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways) {
			locationManager.requestWhenInUseAuthorization()
		}
		locationManager.startUpdatingLocation()
	}
	
	// MARK: CLLocationManagerDelegate
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		self.location.value = location
    getGeoCode()
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
	}
  
  // MARK: GeoCode
  func getGeoCode() {
    guard let location = location.value else { return }
    
    CLGeocoder().reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
      if let _ = error {
        self?.geoLocation.value = ""
        return
      }
      
      guard let placemark = placemarks?.first,
        let locality = placemark.locality,
        let administrativeArea = placemark.administrativeArea
        else {
          self?.geoLocation.value = ""
          return
      }
      
      self?.geoLocation.value = "\(locality), \(administrativeArea)"
    }
  }
}
