//
//  CitiesListViewController.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 22/08/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import UIKit
import CoreLocation
import MKBeaconXProSDK

class CitiesListViewController: ParentViewController {
    
    var otherCitiesNamesArray = [String]()
    let locationManager = CLLocationManager()

    // UI
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
           MKBXPCentralManager.shared().notifyTHData(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveHTData(_:)), name: NSNotification.Name.MKBXPReceiveHTData, object: nil)
           self.readSampleRate()
        
          // Configure tableView
              self.tableView.register(CititesListTableViewCell.nib, forCellReuseIdentifier: CititesListTableViewCell.identifier)
              self.tableView.delegate = self
              self.tableView.dataSource = self
              self.tableView.separatorStyle = .none
              self.tableView.rowHeight = UITableView.automaticDimension
          
             setupLocationManager()
    }
    
    func setupLocationManager() -> () {
           locationManager.requestAlwaysAuthorization()
           locationManager.requestWhenInUseAuthorization()
           if CLLocationManager.locationServicesEnabled() {
               locationManager.delegate = self
               locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
               locationManager.startUpdatingLocation()
           }
       }
    
    @objc func receiveHTData(_ notification: Notification) -> () {
        print(notification.object)
    }
    
    func readSampleRate()->(){
        
        MKBXPInterface.readBXPHTSamplingRate(successBlock: { (returned) in
            print(returned)
        }) { (error) in
            print("EEEEE\(error)")
        }
    
    }
    
    
    
    @IBAction func addCitiesBarButtonAction(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: AddCitiesViewController.identifier) as! AddCitiesViewController
               vc.delegate = self
               self.present(vc, animated: true, completion: nil)
    }
    

}


extension CitiesListViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{ // currentCity
            return 1
        }else{ // otherCities
            return otherCitiesNamesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cityName = ""
        if indexPath.section == 0{ //  current city
            cityName = "Current City"
        }
        else if indexPath.section == 1{ // other cities
            cityName = otherCitiesNamesArray[indexPath.row]
        }
        else{ // other wise
            cityName = ""
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CititesListTableViewCell.identifier, for: indexPath) as! CititesListTableViewCell
        cell.cityNameString = cityName
        cell.loadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
       
        if indexPath.section == 0{ // current city
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: WeatherDetailsViewController.identifier) as! WeatherDetailsViewController
            vc.isCurrentCity = true
            guard let locationValue: CLLocation = locationManager.location else { return }
            vc.commingLocationCoordinate = locationValue.coordinate
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{ // other cities
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: WeatherDetailsViewController.identifier) as! WeatherDetailsViewController
            vc.isCurrentCity = false
            vc.commingCityName = self.otherCitiesNamesArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension CitiesListViewController: AddCitiesViewControllerProtocol{
    func didPressSubmitButton(citiesNamesArray: [String]) {
        self.otherCitiesNamesArray = citiesNamesArray
        self.tableView.reloadData()
    }

}

extension CitiesListViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //  guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //  print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
