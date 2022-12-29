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
    var place: Place!
    var placeImage = BFImageView(frame: .zero)
    var tips: [Tip] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlaceTips()
        configureViewController()
        layoutUI()
        configureUIElements(with: place, tips: tips)
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
        
        
        view.addSubview(tipsView)
        tipsView.backgroundColor = .systemPink
        tipsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tipsView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tipsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tipsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tipsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func configureUIElements(with place: Place, tips: [Tip]) {
        self.add(childVC: BFPlaceInfoHeadVC(place: place), to: self.headerView)
        self.add(childVC: BFTipsVC(place: place, tips: tips), to: self.tipsView)
    }


    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func getPlaceTips() {
        NetworkManager.shared.getPlaceTips(for: place.fsqID) { [weak self] result in
            guard let self else { return }

            switch result {
            case.success(let tips):
                self.tips = tips
                print(self.tips)
            case .failure(let error):
                self.presentBFAlert(title: "Something bad happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
