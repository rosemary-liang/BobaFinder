//
//  PlaceInfoVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

class PlaceInfoVC: UIViewController, TipsDelegate {
    
//    let mainScrollView  = UIView(frame: .zero)

    let headerView      = UIView()
    let tipsScrollView  = UIScrollView(frame: .zero)
    let tipsView        = UIView()
    let actionButton    = BFButton(backgroundColor: .systemIndigo, title: "Add to Favorites")
    let tipsTitleLabel  = BFTitleLabel(textAlignment: .left, fontSize: 28)
    let placeImage      = BFImageView(frame: .zero)
    
    
    var place: Place!
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    lazy var mainScrollView: UIScrollView = {
        let view                            = UIScrollView(frame: .zero)
        view.backgroundColor                = .systemBackground
        view.frame                          = self.view.bounds
        view.contentSize                    = contentViewSize
        view.showsVerticalScrollIndicator   = true
        view.bounces                        = true
        return view
    }()
    
    lazy var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemMint
        view.frame.size = contentViewSize
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureUIElements(with: place)
        configureActionButton()
    }
    
    
    
    func tipsIsEmpty(tips: [Tip]) {
        if tips.isEmpty {
            print("is empty")
            let parentVC = tipsView.findViewController()
            let message = "No tips added for this boba place."
            
            parentVC?.showEmptyStateView(with: message, in: tipsScrollView, scaleX: 0.75, scaleY: 0.75)
        }
    }
    
    func configureViewController() {
        let padding: CGFloat = 20
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainContainerView)
        
        mainContainerView.addSubview(headerView)
        mainContainerView.addSubview(actionButton)
        mainContainerView.addSubview(tipsTitleLabel)
        mainContainerView.addSubview(tipsView)
        
        tipsTitleLabel.text                                         = "Tips"
        headerView.backgroundColor                                  = .systemBackground
        
        mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints        = false
        tipsTitleLabel.translatesAutoresizingMaskIntoConstraints    = false
        tipsView.translatesAutoresizingMaskIntoConstraints          = false
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: -60),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            actionButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding + 20),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            
            tipsTitleLabel.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: padding),
            tipsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tipsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tipsTitleLabel.heightAnchor.constraint(equalToConstant: 35),

            tipsView.topAnchor.constraint(equalTo: tipsTitleLabel.bottomAnchor),
            tipsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tipsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tipsView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor)
        ])
    }
    
    
//    private func configureViewController() {
//        view.backgroundColor = .systemBackground
//        let padding: CGFloat = 20
//
//        view.addSubview(headerView)
//        view.addSubview(actionButton)
//        view.addSubview(tipsTitleLabel)
//        view.addSubview(tipsScrollView)
//        tipsScrollView.addSubview(tipsView)
////        view.addSubview(tipsView)
//
//        tipsTitleLabel.text                                         = "Tips"
//        headerView.backgroundColor                                  = .systemBackground
////        tipsScrollView.contentSize                                  = CGSize(width: tipsView.bounds.width, height: tipsView.bounds.height + 100)
//        headerView.translatesAutoresizingMaskIntoConstraints        = false
//        tipsScrollView.translatesAutoresizingMaskIntoConstraints    = false
//        tipsView.translatesAutoresizingMaskIntoConstraints          = false
//
//        NSLayoutConstraint.activate([
//            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -70),
//            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            headerView.heightAnchor.constraint(equalToConstant: 200),
//
//            actionButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding + 30),
//            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
//            actionButton.heightAnchor.constraint(equalToConstant: 50),
//
//            tipsTitleLabel.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: padding + 10),
//            tipsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//            tipsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
//            tipsTitleLabel.heightAnchor.constraint(equalToConstant: 35),
//
//            tipsScrollView.topAnchor.constraint(equalTo: tipsTitleLabel.bottomAnchor),
//            tipsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tipsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tipsScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//
//            tipsView.topAnchor.constraint(equalTo: tipsScrollView.topAnchor),
//            tipsView.leadingAnchor.constraint(equalTo: tipsScrollView.leadingAnchor),
//            tipsView.trailingAnchor.constraint(equalTo: tipsScrollView.trailingAnchor),
//            tipsView.bottomAnchor.constraint(equalTo: tipsScrollView.bottomAnchor)
//
////            tipsView.topAnchor.constraint(equalTo: tipsTitleLabel.bottomAnchor),
////            tipsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
////            tipsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
////            tipsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding - 30)
//        ])
//    }
    
    
    private func configureUIElements(with place: Place) {
        self.add(childVC: BFPlaceInfoHeadVC(place: place), to: self.headerView)
        
        let tipsVC = BFTipsVC(place: place)
        tipsVC.delegate = self
        self.add(childVC: tipsVC, to: self.tipsView)
    }


    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    private func configureActionButton() {
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
