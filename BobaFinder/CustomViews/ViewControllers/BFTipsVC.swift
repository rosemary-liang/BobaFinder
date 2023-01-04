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
    
    var place: Place!
    var tips: [Tip] = []
    var collectionView: UICollectionView!
   
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Tip>!
    
    init(place: Place ) {
        super.init(nibName: nil, bundle: nil)
        self.place = place
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlaceTips()
        configureCollectionView()
        configureDataSource()

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureCollectionView() {
//        let collectionFrame = CGRect(x: 0, y: 60, width: view.frame.width, height: 200)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createSingleColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(TipCell.self, forCellWithReuseIdentifier: TipCell.reuseId)
//        let numberOfRows = Int(self.tips.count)
//        collectionView.contentSize = CGSizeMake(self.view.frame.size.width, CGFloat(numberOfRows))
    
//        collectionView.dataSource = self

    }
    
    
    func createSingleColumnFlowLayout() -> UICollectionViewFlowLayout {
        let padding: CGFloat              = 20
//        let minimumItemSpacing: CGFloat   = 12
        let itemWidth                     = view.bounds.width - (padding * 2)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 140)
//        flowLayout.scrollDirection = .vertical

        
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
        showLoadingView()
        
        Task {
            do {
                tips = try await NetworkManager.shared.getPlaceTips(for: place.fsqID)
                updateData()
                updateUI()
                dismissLoadingView()
            } catch {
                if let bfError = error as? BFError {
                    presentBFAlert(title: "Something bad happened", message: bfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                dismissLoadingView()
            }
        }
    }
    
    
    func updateUI() {
        if tips.isEmpty {
            let message = "No tips added for this boba place."
            self.showEmptyStateView(with: message, in: self.view, scaleX: 0.75, scaleY: 0.75)
        }
    }
}

//extension BFTipsVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    
//}
