//
//  Networking.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 22/08/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MobileCoreServices

struct Networking {
    private static var appIDString: String {
       // return "b6907d289e10d714a6e88b30761fae22"
        return "74dc75e088e0d3a6be26d76afaf77396" //live
    }
    private static var serverUrl: String{
       // return "https://samples.openweathermap.org/data/2.5/forecast?"
        return "http://api.openweathermap.org/data/2.5/forecast?" // live
    }

    private static func getURLByCityName(_ cityName: String) -> URL{
        let urlString =  serverUrl + "q=\(cityName)&units=metric&appid=\(appIDString)"
        return URL(string: urlString)!
    }
    private static func getURLByCityCoordinates(_ lat: String, _ long: String) -> URL{
         let urlString =  serverUrl + "lat=\(lat)&lon=\(long)&units=metric&appid=\(appIDString)"
         return URL(string: urlString)!
    }
    
    
    
    public static func get(_ url: URL, _ completionHandler: @escaping (Data?)->()) {
           let urlString = url.absoluteString
//           let httpheaders: HTTPHeaders = [
//               "language" : "en",
//           ]

           print(urlString)
           let finalUrl = URL(string: urlString)!
           Alamofire.request(finalUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { response in
              
               switch response.result{
               case .success( _):
                   
//                   let dict = try? JSONSerialization.jsonObject(with: response.result.value!, options: []) as? [String : Any]
                   completionHandler(response.data)
               case .failure(let error):
                   print(error)
                   completionHandler(nil)
               }
           }
           
       }
    
 
    
    struct WeatherRequests {
        static func  getWeatherDetailsByCityName(_ cityName: String,_ completionHandler : @escaping (WeatherDetailsModel?)->()){
            //  replace white spaces in city name by %20
            let cityNameString = cityName.replaceSpaceInString()
            let url : URL = getURLByCityName(cityNameString)
            get(url) { (json) in
                if json != nil
                {
                    let jsonSS = try? JSON(data: json!)
                    print(jsonSS)
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try? jsonDecoder.decode(WeatherDetailsModel.self, from: json!)
                    completionHandler(responseModel)
                }
                else
                {
                    completionHandler(nil)
                }
            }
        }
        
        static func  getWeatherDetailsByCityCoordinates(_ lat: String,_ long:String,_ completionHandler : @escaping (WeatherDetailsModel?)->()){
            let url : URL = getURLByCityCoordinates(lat,long)
            get(url) { (json) in
                if json != nil
                {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try? jsonDecoder.decode(WeatherDetailsModel
                        .self, from: json!)
                    completionHandler(responseModel)
                }
                else
                {
                    completionHandler(nil)
                }
            }
        }
    }
    
    
}
