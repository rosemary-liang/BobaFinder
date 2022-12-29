//
//  BFTipsVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

//class BFTipsVC: UIViewController {
//    
//    enum Section {
//        case main
//    }
//    
//    var place: Place
//    var tips: [Tip] = []
//    var collectionView: UICollectionView!
//    
//    var dataSource: UICollectionViewDiffableDataSource<Section, Tip>!
//    
//    init(place: Place) {
//        self.place = place
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureViewController()
//        configureCollectionView()
//        
////        configureDataSource()
//
//
//    }
//    
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func configureViewController() {
//        // anything here?
//    }
//    
//    
//    private func configureCollectionView() {
//        let collectionFrame = CGRect(x: 0, y: 60, width: view.frame.width, height: 200)
//        collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: createHorizontalFlowLayout())
//        collectionView.register(TipCell.self, forCellWithReuseIdentifier: TipCell.reuseId)
//    
//    }
//    
//    
//    func createHorizontalFlowLayout() -> UICollectionViewFlowLayout {
//        let width                         = view.bounds.width
//        let padding: CGFloat              = 12
//        let minimumItemSpacing: CGFloat   = 8
////        let availableWidth: CGFloat       = width - (padding * 2) - (minimumItemSpacing * 2)
//        let itemWidth                     = 200
//        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.minimumLineSpacing = minimumItemSpacing
//        flowLayout.minimumInteritemSpacing = minimumItemSpacing
//        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
//        flowLayout.itemSize = CGSize(width: itemWidth, height: 170)
//        
//        return flowLayout
//    }
//    
//    func getTips() {
//        NetworkManager.shared.getPlaceTips(for: place.fsqID) { [weak self] result in
//            switch result {
//            case .success(let tips):
//                self.tips = tips
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.presentBFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
//                }
//            }
//                
//        }
//    }
//    
//    
//    func configureDataSource() {
//        
//    }
//    
//}
