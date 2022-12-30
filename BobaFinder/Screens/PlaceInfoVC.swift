//
//  PlaceInfoVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

//protocol PlaceInfoVCDelegate: AnyObject {
//    func didTapAddToFavorites(for place: Place)
//}

class PlaceInfoVC: UIViewController {
    
    let headerView      = UIView()
    let tipsView        = UIView()
    let actionButton    = BFButton(backgroundColor: .systemIndigo, title: "Add to Favorites")
    let tipsTitleLabel  = BFTitleLabel(textAlignment: .left, fontSize: 28)
    let placeImage      = BFImageView(frame: .zero)
    
    var place: Place!
//    weak var delegate: PlaceInfoVCDelegate!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureUIElements(with: place)
        configureActionButton()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        let padding: CGFloat = 20
        
        view.addSubview(headerView)
        view.addSubview(actionButton)
        view.addSubview(tipsTitleLabel)
        view.addSubview(tipsView)
        
        tipsTitleLabel.text         = "Tips"
        headerView.backgroundColor  = .systemBackground
        headerView.translatesAutoresizingMaskIntoConstraints = false
        tipsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
        
            actionButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding + 30),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
  
            tipsTitleLabel.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: padding + 10),
            tipsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tipsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tipsTitleLabel.heightAnchor.constraint(equalToConstant: 35),

            tipsView.topAnchor.constraint(equalTo: tipsTitleLabel.bottomAnchor),
            tipsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tipsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tipsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    func configureUIElements(with place: Place) {
        self.add(childVC: BFPlaceInfoHeadVC(place: place), to: self.headerView)
        self.add(childVC: BFTipsVC(place: place), to: self.tipsView)
    }


    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
    }
    
    
    @objc func actionButtonTapped() {
        let favorite = place!
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self else { return }
            guard let error else {
                self.presentBFAlert(title: "Success!", message: "Place has been successfully favorited.", buttonTitle: "Ok")
                return
            }
            self.presentBFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
