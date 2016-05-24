//
//  Weather.swift
//  GoldWeather
//
//  Created by Henrique Dourado on 22/05/16.
//  Copyright © 2016 Henrique Dourado. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    
    private var _temperature: String!
    private var _description: String!
    private var _humidity: String!
    private var _maximumTemp: String!
    private var _minimumTemp: String!
    private var _pressure: String!
    private var _windSpeed: String!
    
    
    var temperature: String {
        return _temperature
    }
    
    var description: String {
        return _description
    }
    
    var humidity: String {
        return _humidity
    }
    
    var maximumTemp: String {
        return _maximumTemp
    }
    
    var minimumTemp: String {
        return _minimumTemp
    }
    
    var pressure: String {
        return _pressure
    }
    
    var windSpeed: String {
        return _windSpeed
    }
    
    init() {
        
    }
    
    func downloadData(city: String, completed: DownloadComplete) {
        
        let formattedCity_1 = city.stringByReplacingOccurrencesOfString(" ", withString: "")
        let formattedCity_2 = formattedCity_1.stringByReplacingOccurrencesOfString("ã", withString: "a")
        let URL = "\(BASE_URL)\(formattedCity_2)\(API_KEY)"
        print(URL)
        
        Alamofire.request(.GET, URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>] {
                    if let desc = weather[0]["description"] as? String {
                        self._description = desc.capitalizedString
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String,AnyObject>{
                    if let temp = main["temp"] as? Double {
                        self._temperature = self.getCelsiusFromKelvin(temp)
                    }
                    
                    if let pressure = main["pressure"] as? Double {
                        self._pressure = String(pressure)
                    }
                    
                    if let hum = main["humidity"] as? Double {
                        self._humidity = String(hum)
                    }
                    
                    if let max = main["temp_max"] as? Double {
                        self._maximumTemp = self.getCelsiusFromKelvin(max)
                    }
                    
                    if let min = main["temp_min"] as? Double {
                        self._minimumTemp = self.getCelsiusFromKelvin(min)
                    }
                }
                
                if let wind = dict["wind"] as? Dictionary<String, Double> {
                    if let windSpeed = wind["speed"] {
                        self._windSpeed = String(windSpeed)
                        
                        completed()
                    }
                }
            }
        }
    }
    
    private func getCelsiusFromKelvin(temperatureInKelvins: Double) -> String {
        return "\(temperatureInKelvins - 273.0)°C"
    }
}