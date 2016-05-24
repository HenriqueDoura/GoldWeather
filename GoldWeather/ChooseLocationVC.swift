//
//  ChooseLocationVC.swift
//  GoldWeather
//
//  Created by Henrique Dourado on 22/05/16.
//  Copyright © 2016 Henrique Dourado. All rights reserved.
//

import UIKit

class ChooseLocationVC: UIViewController {
    
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var searchWeatherBtn: UIButton!
    @IBOutlet weak var weatherForCityLbl: UILabel!
    @IBOutlet weak var minimumLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var maxLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            searchWeatherBtn.layer.cornerRadius = 10.0
            mainStackView.alpha = 0
            weatherForCityLbl.alpha = 0
    }
    
    @IBAction func searchWeatherBtnPressed(sender: AnyObject) {
        if let city = cityTxtField.text where city != "" {
            UIView.animateWithDuration(0.3, animations: {
               self.weatherForCityLbl.alpha = 0
               self.mainStackView.alpha = 0
            })
            
            let weather = Weather()
            
                weather.downloadData(city, completed: {
                    self.minimumLbl.text = weather.minimumTemp
                    self.maxLbl.text = weather.maximumTemp
                    self.humidityLbl.text = weather.humidity
                    self.tempLbl.text = weather.temperature
                    self.pressureLbl.text = weather.pressure
                    self.descriptionLbl.text = weather.description
                    self.windSpeedLbl.text = weather.windSpeed
                    
                    let f = NSDateFormatter()
                    f.dateStyle = .LongStyle
                    f.timeStyle = .NoStyle
                    
                    self.weatherForCityLbl.text = "Weather for \(city) on \(f.stringFromDate(NSDate()))"
                    
                    UIView.animateWithDuration(0.3, animations: {
                        self.weatherForCityLbl.alpha = 1
                        self.mainStackView.alpha = 1
                    })
                })
        } else {
            let alert = UIAlertController(title: "Error", message: "You must enter a city name", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}