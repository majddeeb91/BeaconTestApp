//
//  StringExtensions.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 22/08/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import Foundation

extension String{
    func isBlank() -> Bool {
      for character in self {
        if !character.isWhitespace {
            return false
        }
      }
      return true
    }
    
    func replaceSpaceInString() -> (String){
          let new = self.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
           return new
       }
}
