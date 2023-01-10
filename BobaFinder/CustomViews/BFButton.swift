//
//  BFButton.swift
//  BobaFinder
//
//  Created by Rosemary Liang on 12/23/22.
//

import UIKit

class BFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        set(color: backgroundColor, title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configuration               = .filled()
        configuration?.cornerStyle  = .medium
    }
    
    private func set(color: UIColor, title: String) {
        configuration?.baseBackgroundColor  = color
        configuration?.title                = title
    }
}
