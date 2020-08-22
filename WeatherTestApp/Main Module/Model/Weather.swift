//
//  WeatherDetailsModel.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 22/08/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import Foundation
struct Weather : Codable {
	let id : Int?
	let main : String?
	let descriptionW : String?
	let icon : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case main = "main"
		case descriptionW = "description"
		case icon = "icon"
	}

	init(from decoder: Decoder) throws {
		let values = try? decoder.container(keyedBy: CodingKeys.self)
		id = try? values?.decodeIfPresent(Int.self, forKey: .id)
		main = try? values?.decodeIfPresent(String.self, forKey: .main)
		descriptionW = try? values?.decodeIfPresent(String.self, forKey: .descriptionW)
		icon = try? values?.decodeIfPresent(String.self, forKey: .icon)
	}

}
