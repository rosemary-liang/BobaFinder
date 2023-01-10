//
//  BFTipLabel.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

class BFTipLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        textColor                                   = .secondaryLabel
        font                                        = UIFont.preferredFont(forTextStyle: .subheadline)
        adjustsFontForContentSizeCategory           = true
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.75
        lineBreakMode                               = .byWordWrapping
    }

}
