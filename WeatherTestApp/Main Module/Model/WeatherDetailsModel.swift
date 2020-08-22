//
//  WeatherDetailsModel.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 22/08/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import Foundation
struct WeatherDetailsModel : Codable {
    let cod : String?
    let message : Double?
    let cnt : Int?
    let list : [List]?
    let city : City?

    enum CodingKeys: String, CodingKey {

        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }

    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        cod = try? values?.decodeIfPresent(String.self, forKey: .cod)
        message = try? values?.decodeIfPresent(Double.self, forKey: .message)
        cnt = try? values?.decodeIfPresent(Int.self, forKey: .cnt)
        list = try? values?.decodeIfPresent([List].self, forKey: .list)
        city = try? values?.decodeIfPresent(City.self, forKey: .city)
    }

}
