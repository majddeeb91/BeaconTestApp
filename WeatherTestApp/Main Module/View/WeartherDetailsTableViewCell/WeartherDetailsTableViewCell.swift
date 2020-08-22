//
//  WeartherDetailsTableViewCell.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 22/08/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import UIKit

class WeartherDetailsTableViewCell: UITableViewCell {

    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var currentListItem: List!
    
    @IBOutlet weak var containerView: UIView!{
        didSet{
            if containerView != nil{
                containerView.layer.cornerRadius = 15
                containerView.layer.shadowOffset = CGSize.zero
                containerView.layer.shadowOpacity = 0.2
                containerView.layer.shadowRadius = 3
                containerView.layer.shadowColor = UIColor.black.cgColor
                containerView.layer.borderColor = UIColor.white.cgColor
                containerView.layer.borderWidth = 0.5
            }
        }
    }
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadData() -> () {
          
               let maxTempString = String(describing: Int(currentListItem.main?.temp_max ?? 0))
               let minTempString = String(describing: Int(currentListItem.main?.temp_min ?? 0))
               let currentWeather =  currentListItem.weather![0]
               let currentWeatherDesc = currentWeather.descriptionW ?? ""
               let windSpeed = currentListItem.wind?.speed ?? 0
               
               self.maxTempLabel.text = "\(maxTempString)°"
               self.minTempLabel.text = "\(minTempString)°"
               self.weatherDescriptionLabel.text = currentWeatherDesc
               self.windSpeedLabel.text = "Wind Speed: \(windSpeed)"
               
               let dateString = currentListItem.dt_txt ?? ""
               let dateFormatter = DateFormatter()
               dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
               dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
               let date = dateFormatter.date(from:dateString)
               dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
               let finaldateString = dateFormatter.string(from: date!)
               self.dayNameLabel.text = finaldateString
        
        
        
    }
    
}
