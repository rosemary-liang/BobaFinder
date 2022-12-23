//
//  BFTextField.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

class BFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.systemGray4.cgColor
        layer.cornerRadius  = 8
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font    = .preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing
        placeholder = "Enter a zipcode"
    }
}