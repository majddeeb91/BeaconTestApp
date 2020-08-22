//
//  AddCitiesViewController.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 22/08/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import UIKit

class AddCitiesViewController: UIViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    var citiesNamesArray = [String]()
    var  delegate: AddCitiesViewControllerProtocol!
    
    // UI
    @IBOutlet weak var citiesNamesTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!{
        didSet{
            if submitButton != nil{
                submitButton.layer.cornerRadius = 17
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitButtonAction(_ sender: Any) {
        if citiesNamesTextField.empty{
            self.presentAlert(with: "Please enter city name", title: "Alert")
        }
        else{
            // validate cities count
            self.citiesNamesArray = (self.citiesNamesTextField.text?.components(separatedBy: ","))!
            if self.citiesNamesArray.count < 1 || self.citiesNamesArray.count > 7{
                self.presentAlert(with: "minimum cities count is 1", title: "Alert")
            }
            else{
                for city in citiesNamesArray{
                    if city.isBlank(){
                        self.presentAlert(with: "City can't be empty", title: "Alert")
                        return
                    }
                }
                self.dismiss(animated: true) {
                    self.delegate.didPressSubmitButton(citiesNamesArray: self.citiesNamesArray)
                }
            }
        }
        
    }
    
    
}

protocol AddCitiesViewControllerProtocol {
    func didPressSubmitButton(citiesNamesArray: [String])
}
