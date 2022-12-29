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
//        configureViewController()
        configureCollectionView()
        configureDataSource()

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func configureViewController() {
//        view.addSubview(tipsTitleLabel)
//        tipsTitleLabel.text = "Tips"
//
//        NSLayoutConstraint.activate([
//            tipsTitleLabel.topAnchor.constraint(equalTo: view.topAnchor),
//            tipsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tipsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tipsTitleLabel.heightAnchor.constraint(equalToConstant: 30)
//        ])
//
//    }
    
    private func configureCollectionView() {
//        let collectionFrame = CGRect(x: 0, y: 60, width: view.frame.width, height: 200)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createSingleColumnFlowLayout())
        view.addSubview(collectionView)
        
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: tipsTitleLabel.bottomAnchor, constant: 15),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
        
        collectionView.register(TipCell.self, forCellWithReuseIdentifier: TipCell.reuseId)
//        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.reuseId)
//
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.reuseId, for: indexPath) as! HeaderCollectionReusableView
//        header.configure()
//        return header
    }
    
    
    func createSingleColumnFlowLayout() -> UICollectionViewFlowLayout {
        let padding: CGFloat              = 20
        let itemWidth                     = view.bounds.width - (padding * 2)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 140)
        
        return flowLayout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Tip>(collectionView: collectionView, cellProvider: { collectionView, indexPath, tip in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TipCell.reuseId, for: indexPath) as! TipCell
            cell.set(tip: tip)
            cell.backgroundColor = .systemGray5
            cell.layer.cornerRadius = 10
            cell.alpha = 0.5
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
