//
//  String+Ext.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/27/22.
//

import UIKit

extension String {
    
    var isValidFiveDigitZipcode: Bool {
        let zipcodeFormat = "\\b\\d{5}(?:[ -]\\d{4})?\\b"
        let zipcodePredicate = NSPredicate(format: "SELF MATCHES %@", zipcodeFormat)
        return zipcodePredicate.evaluate(with: self)
    }
}
