//
//  ViewController.swift
//  LoChanger
//
//  Created by Nolan Lapham on 2/27/17.
//  Copyright © 2017 Nolan Lapham. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift

class ViewController: UIViewController {

  @IBOutlet weak var locationLabel: UILabel!
  
  private var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupObservables()
  }

  private func setupObservables() {
    LocationService.sharedInstance.geoLocation.asObservable().subscribe({ [weak self] _ in
      self?.locationLabel.text = LocationService.sharedInstance.geoLocation.value ?? ""
    }).addDisposableTo(disposeBag)
  }
}
