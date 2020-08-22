//
//  WeatherDetailsModel.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 22/08/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import Foundation
struct Wind : Codable {
	let speed : Double?
	let deg : Double?

	enum CodingKeys: String, CodingKey {

		case speed = "speed"
		case deg = "deg"
	}

	init(from decoder: Decoder) throws {
		let values = try? decoder.container(keyedBy: CodingKeys.self)
		speed = try? values?.decodeIfPresent(Double.self, forKey: .speed)
		deg = try? values?.decodeIfPresent(Double.self, forKey: .deg)
	}

}
