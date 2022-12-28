//
//  PlacesListVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

class PlacesListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var zipcode: String!
    var places: [Place] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Place>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        configureViewController()
        configureCollectionView()
        getPlaces()
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    private func configureViewController() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createTwoColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(PlaceCell.self, forCellWithReuseIdentifier: PlaceCell.reuseID)
    }
    
    
    func createTwoColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width                         = view.bounds.width
        let padding: CGFloat              = 12
        let minimumItemSpacing: CGFloat   = 10
        let availableWidth: CGFloat       = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                     = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = minimumItemSpacing
        flowLayout.minimumInteritemSpacing = minimumItemSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    
    func getPlaces() {
        showLoadingView()
        NetworkManager.shared.getPlaces(for: zipcode) { [weak self] result in
            guard let self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let places):
                
                self.places = places
                self.updateData()
                self.updateUI(with: self.places)
               
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentBFAlert(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    }
    

    func updateUI(with places: [Place]) {
        if self.places.isEmpty {
            let message = "No boba places found. Please try another zipcode."
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
            }
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Place>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, place) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCell.reuseID, for: indexPath) as! PlaceCell
            cell.set(place: place)
            return cell
        })
    }
    
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Place>()
        snapshot.appendSections([.main])
        snapshot.appendItems(places)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences:  true)
        }
    }
}
