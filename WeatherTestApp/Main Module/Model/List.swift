//
//  WeatherDetailsModel.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 22/08/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import Foundation
struct List : Codable {
	let dt : Int?
	let main : Main?
	let weather : [Weather]?
	let clouds : Clouds?
	let wind : Wind?
	//let rain : Rain?
	let sys : Sys?
	let dt_txt : String?

	enum CodingKeys: String, CodingKey {

		case dt = "dt"
		case main = "main"
		case weather = "weather"
		case clouds = "clouds"
		case wind = "wind"
		//case rain = "rain"
		case sys = "sys"
		case dt_txt = "dt_txt"
	}

	init(from decoder: Decoder) throws {
		let values = try? decoder.container(keyedBy: CodingKeys.self)
		dt = try? values?.decodeIfPresent(Int.self, forKey: .dt)
		main = try? values?.decodeIfPresent(Main.self, forKey: .main)
		weather = try? values?.decodeIfPresent([Weather].self, forKey: .weather)
		clouds = try? values?.decodeIfPresent(Clouds.self, forKey: .clouds)
		wind = try? values?.decodeIfPresent(Wind.self, forKey: .wind)
		//rain = try? values?.decodeIfPresent(Rain.self, forKey: .rain)
		sys = try? values?.decodeIfPresent(Sys.self, forKey: .sys)
		dt_txt = try? values?.decodeIfPresent(String.self, forKey: .dt_txt)
	}

}
