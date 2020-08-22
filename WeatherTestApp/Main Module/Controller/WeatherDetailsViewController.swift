//
//  WeatherDetailsViewController.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 22/08/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherDetailsViewController: ParentViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    
    //the blow 3 variables values is comming from  "CitiesListViewController"
    var isCurrentCity = false
    var commingLocationCoordinate: CLLocationCoordinate2D!
    var commingCityName = ""
    
    var currentweatherDetailsModel: WeatherDetailsModel!
    var currentCityList = [List]()
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure tableView
        self.tableView.register(WeartherDetailsTableViewCell.nib, forCellReuseIdentifier: WeartherDetailsTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        
        // check if it is current city that is determined in "CitiesListViewController.swift"
        if isCurrentCity{
            let lat = "\(commingLocationCoordinate.latitude)"
            let long = "\(commingLocationCoordinate.longitude)"
            getWeatherDetailsByCoordinateRequested(lat,long)
        }
        else{
            self.cityNameLabel.text = commingCityName
            getWeatherDetailsByCityNameRequested(cityName: commingCityName)
        }
    }
    
    func loadData() -> () {
        let currentList = self.currentweatherDetailsModel.list
        let currentItem = currentList![0]
        let currentTempString = String(describing: Int(currentItem.main?.temp ?? 0))
        let currentWeather =  currentItem.weather![0]
        let currentWeatherDesc = currentWeather.descriptionW ?? ""
        self.degreeLabel.text = currentTempString + "°"
        self.weatherDescriptionLabel.text = currentWeatherDesc
        self.cityNameLabel.text = self.currentweatherDetailsModel.city?.name ?? ""
        
        
    }
    
    // MARK: - Api Requestes
    func getWeatherDetailsByCityNameRequested(cityName: String){
        self.showLoading()
        Networking.WeatherRequests.getWeatherDetailsByCityName(cityName) { (model) in
            if model != nil{
                if model?.cod != "200"{
                    DispatchQueue.main.async {
                        self.presentErrorAlert(with: "error in api response")
                    }
                }
                else{
                    // show details
                    
                    self.currentweatherDetailsModel = model
                    self.currentCityList = (model?.list)!
                    DispatchQueue.main.async {
                        self.loadData()
                        self.tableView.reloadData()
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    self.presentErrorAlert(with: "General Error")
                }
            }
            DispatchQueue.main.async {
                self.hideLoading()
            }
        }
    }
    
    @objc func getWeatherDetailsByCoordinateRequested(_ lat: String,_ Long:String){
        self.showLoading()
        Networking.WeatherRequests.getWeatherDetailsByCityCoordinates(lat, Long) { (model) in
            if model != nil{
                if model?.cod != "200"{
                    DispatchQueue.main.async {
                        self.presentErrorAlert(with: "error in api response")
                    }
                }
                else{
                    // show details
                    
                    self.currentweatherDetailsModel = model
                    self.currentCityList = (model?.list)!
                    DispatchQueue.main.async {
                        self.loadData()
                        self.tableView.reloadData()
                    }
                    
                }
            }
            else{
                DispatchQueue.main.async {
                    self.presentErrorAlert(with: "General Error")
                }
            }
            
            DispatchQueue.main.async {
                self.hideLoading()
            }
        }
    }
    
}

extension WeatherDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeartherDetailsTableViewCell.identifier, for: indexPath) as! WeartherDetailsTableViewCell
        cell.currentListItem = self.currentCityList[indexPath.row]
        cell.loadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

