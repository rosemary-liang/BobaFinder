//
//  SearchVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

class SearchVC: UIViewController {
    
    var logoImageView       = UIImageView()
    var zipcodeTextField    = BFTextField()
    var actionButton        = BFButton(backgroundColor: .systemIndigo, title: "Find Boba")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    func configure() {
        
        let padding: CGFloat = 50
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo-image")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        
        view.addSubview(zipcodeTextField)
        
        NSLayoutConstraint.activate([
            zipcodeTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: padding),
            zipcodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            zipcodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            zipcodeTextField.heightAnchor.constraint(equalToConstant: padding) // for a large touch target
        ])
        
        
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: zipcodeTextField.bottomAnchor, constant: padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: padding)
        ])
        
        
        
        
    }
    


}
