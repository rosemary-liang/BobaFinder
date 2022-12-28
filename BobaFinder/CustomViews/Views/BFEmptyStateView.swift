//
//  BFEmptyStateView.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/27/22.
//

import UIKit

class BFEmptyStateView: UIView {
    
    let messageLabel = BFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
        
    }
    
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        logoImageView.image         = UIImage(named: "empty-state-image")
        logoImageView.alpha         = 0.80
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            messageLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -10),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
