//
//  BFTipsVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

class BFTipsVC: UIViewController {
    
    enum Section {
        case main
    }
    
    // how to pass place and tips to this?
    var place: Place!
    var tips: [Tip] = []
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Tip>!
    
    init(place: Place ) {
        super.init(nibName: nil, bundle: nil)
        self.place = place
//        self.tips = tips
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlaceTips()
        configureCollectionView()
        configureDataSource()
//        updateData()
        //        configureDataSource()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureCollectionView() {
        let collectionFrame = CGRect(x: 0, y: 60, width: view.frame.width, height: 200)
        collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: createSingleColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(TipCell.self, forCellWithReuseIdentifier: TipCell.reuseId)
    }
    
    
    func createSingleColumnFlowLayout() -> UICollectionViewFlowLayout {
//        let width                         = view.bounds.width
        let padding: CGFloat              = 12
//        let minimumItemSpacing: CGFloat   = 8
        //        let availableWidth: CGFloat       = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                     = view.bounds.width - (padding * 2)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
//        flowLayout.minimumInteritemSpacing = minimumItemSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 170)
        
        return flowLayout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Tip>(collectionView: collectionView, cellProvider: { collectionView, indexPath, tip in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TipCell.reuseId, for: indexPath) as! TipCell
            cell.set(tip: tip)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Tip>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tips)

        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func getPlaceTips() {
        NetworkManager.shared.getPlaceTips(for: place.fsqID) { [weak self] result in
            guard let self else { return }

            switch result {
            case.success(let tips):
                self.tips = tips
                self.updateData()

            case .failure(let error):
                self.presentBFAlert(title: "Something bad happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
