//
//  AppDelegate.swift
//  LoChanger
//
//  Created by Nolan Lapham on 2/27/17.
//  Copyright © 2017 Nolan Lapham. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Start monitoring location
    LocationService.sharedInstance.startUpdatingLocation()
    
    return true
  }


}
