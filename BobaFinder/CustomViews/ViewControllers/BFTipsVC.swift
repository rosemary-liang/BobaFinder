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
    
    func getPlaceTips() {
        showLoadingView()
        
        Task {
            do {
                tips = try await NetworkManager.shared.getPlaceTips(for: place.fsqID)
                updateData()
                updateUI(with: self.tips)
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
    
    func updateUI(with tips: [Tip]) {
        if tips.isEmpty {
            let message = "No tips added for this boba place."
            showEmptyStateView(with: message, in: self.view, scaleX: 0.75, scaleY: 0.75, translateY: 225.0)
        }
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createSingleColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(TipCell.self, forCellWithReuseIdentifier: TipCell.reuseId)
    }
    
    private func createSingleColumnFlowLayout() -> UICollectionViewFlowLayout {
        let padding: CGFloat              = 15
        let itemWidth                     = view.bounds.width - (padding * 2)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 140)

        return flowLayout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Tip>(collectionView: collectionView,
                                                                      cellProvider: { collectionView, indexPath, tip in
            // swiftlint:disable force_cast
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TipCell.reuseId, for: indexPath) as! TipCell
            // swiftlint:enable force_cast
            cell.set(tip: tip)
            cell.backgroundColor = .systemGray5
            cell.layer.cornerRadius = 10
            cell.alpha = 0.5
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Tip>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tips)

        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
