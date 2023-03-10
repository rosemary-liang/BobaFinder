//
//  BFAlertContainerView.swift
//  BobaFinder
//
//  Created by Rosemary Liang on 12/23/22.
//

import UIKit

class BFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor                           = .systemBackground
        layer.cornerRadius                        = 14
        layer.borderWidth                         = 1
        layer.borderColor                         = UIColor.white.cgColor

    }
}
