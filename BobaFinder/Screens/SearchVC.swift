//
//  SearchVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView       = UIImageView()
    let titleLabel          = BFTitleLabel(textAlignment: .center, fontSize: 50)
    let zipcodeTextField    = BFTextField()
    let actionButton        = BFButton(backgroundColor: .systemIndigo, title: "Find Boba")
    
    var isZipcodeEntered: Bool { return !zipcodeTextField.text!.isEmpty }
    
    let padding: CGFloat = 50
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        configureUIElements()
        layoutUI()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    @objc func pushPlacesListVC() {
        guard isZipcodeEntered  else {
            presentBFAlert(title: "Empty zipcode", message: "Please enter a zipcode so we can search for nearby boba places.", buttonTitle: "Ok")
            return
        }
        
        guard zipcodeTextField.text!.isValidFiveDigitZipcode else {
            presentBFAlert(title: "Invalid zipcode", message: "Please enter a valid 5-digit zipcode so we can search for nearby boba places.", buttonTitle: "Ok")
            return
        }
    
        
        let placesListVC    = PlacesListVC()
        placesListVC.zipcode        = zipcodeTextField.text
        placesListVC.title        = "Boba near \(zipcodeTextField.text ?? "")"
        navigationController?.pushViewController(placesListVC, animated: true)
    }
    
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(zipcodeTextField)
        view.addSubview(actionButton)
    }
    
    
    private func configureUIElements() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo-image")
        
        titleLabel.text = "boba finder"
        
        zipcodeTextField.tintColor      = .systemTeal
        zipcodeTextField.alpha          = 0.80
        zipcodeTextField.delegate       = self
        
        actionButton.addTarget(self, action: #selector(pushPlacesListVC), for: .touchUpInside)
    }
    
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 100),
            
            zipcodeTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            zipcodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            zipcodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            zipcodeTextField.heightAnchor.constraint(equalToConstant: padding), // for a large touch target
            
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushPlacesListVC()
        return true
    }
}
