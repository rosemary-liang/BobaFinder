//
//  BFEmptyStateView.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/27/22.
//

import UIKit

class BFEmptyStateView: UIView {
    
    let messageLabel = BFTitleLabel(textAlignment: .center, fontSize: 26)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureUIElements()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    private func addSubviews() {
        addSubview(messageLabel)
        addSubview(logoImageView)
    }
    
    
    private func configureUIElements() {
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        logoImageView.image         = UIImage(named: "empty-state-image")
        logoImageView.alpha         = 0.80
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -90),
            logoImageView.widthAnchor.constraint(equalToConstant: 190),
            logoImageView.heightAnchor.constraint(equalToConstant: 190),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -10),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
