//
//  WeatherDetailsModel.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 22/08/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import Foundation
struct Sys : Codable {
	let pod : String?

	enum CodingKeys: String, CodingKey {

		case pod = "pod"
	}

	init(from decoder: Decoder) throws {
		let values = try? decoder.container(keyedBy: CodingKeys.self)
		pod = try? values?.decodeIfPresent(String.self, forKey: .pod)
	}

}
