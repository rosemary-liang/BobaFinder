//
//  PlaceInfoVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

class PlaceInfoVC: UIViewController {
    
    let headerView = UIView()
    let tipsView = UIView()
    let tipsTitleLabel = BFTitleLabel(textAlignment: .left, fontSize: 28)
    var place: Place!
    var placeImage = BFImageView(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        configureUIElements(with: place)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    func layoutUI() {
        view.addSubview(headerView)
        headerView.backgroundColor = .systemBackground
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(tipsTitleLabel)
        tipsTitleLabel.text = "Tips"
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            tipsTitleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding + 20),
            tipsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tipsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tipsTitleLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        
        view.addSubview(tipsView)
        tipsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tipsView.topAnchor.constraint(equalTo: tipsTitleLabel.bottomAnchor),
            tipsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tipsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tipsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
    
}
