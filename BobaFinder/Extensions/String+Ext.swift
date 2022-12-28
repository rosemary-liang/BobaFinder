//
//  String+Ext.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/27/22.
//

import UIKit

extension String {
    func encodeURL() -> String? {
            addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)?
                .replacingOccurrences(of: "&", with: "%26")
        }
}
