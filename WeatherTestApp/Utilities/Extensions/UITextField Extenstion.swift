//
//  UITextField Extenstion.swift
//  yormas
//

import Foundation
import UIKit

extension UITextField{
    var empty: Bool{
        return !((self.text != nil) && (self.text!.count != 0))
    }
}
