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
        view.backgroundColor = .systemCyan
        configureLogoImageView()
        configureTitleLabel()
        configureZipcodeTextField()
        configureActionButton()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushPlacesListVC() {
        guard isZipcodeEntered else {
            print("no username entered")
            return
        }
        let placesListVC    = PlacesListVC()
        placesListVC.zipcode        = zipcodeTextField.text
        placesListVC.title        = "Boba near \(zipcodeTextField.text ?? "")"
        navigationController?.pushViewController(placesListVC, animated: true)
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo-image")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Boba Finder"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    func configureZipcodeTextField() {
        view.addSubview(zipcodeTextField)
        zipcodeTextField.tintColor = .systemTeal
        zipcodeTextField.alpha = 0.80
        zipcodeTextField.delegate = self
        
        NSLayoutConstraint.activate([
            zipcodeTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            zipcodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            zipcodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            zipcodeTextField.heightAnchor.constraint(equalToConstant: padding) // for a large touch target
        ])
    }
    
    
    func configureActionButton() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(pushPlacesListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushPlacesListVC()
        return true
    }
}
