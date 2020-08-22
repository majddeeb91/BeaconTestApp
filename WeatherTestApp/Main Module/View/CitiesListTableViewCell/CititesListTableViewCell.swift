//
//  CititesListTableViewCell.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 22/08/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import UIKit

class CititesListTableViewCell: UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var cityNameString = ""
    
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
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData() -> () {
        self.cityNameLabel.text = cityNameString
    }
    
}
