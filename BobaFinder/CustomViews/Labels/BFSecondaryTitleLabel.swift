//
//  BFSecondaryTitleLabel.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

class BFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font          = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        textColor                                   = .secondaryLabel
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.90
        lineBreakMode                               = .byWordWrapping
    }
    
}
