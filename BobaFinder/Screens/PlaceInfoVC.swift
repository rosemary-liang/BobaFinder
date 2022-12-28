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
    var tips: [Tip] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
//        getPlaceTips()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    func configureUIElements(with place: Place) {
        self.add(childVC: BFTipsVC(place: place), to: self.tipsView)
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
//    func getPlaceTips() {
//        NetworkManager.shared.getPlaceTips(for: place.fsqID) { [weak self] result in
//            guard let self else { return }
//
//            switch result {
//            case.success(let tips):
//                self.tips = tips
//                print(self.tips)
//            case .failure(let error):
//                self.presentBFAlert(title: "Something bad happened", message: error.rawValue, buttonTitle: "Ok")
//            }
//        }
//    }
}
