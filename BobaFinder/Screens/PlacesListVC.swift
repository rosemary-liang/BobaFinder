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
    var places: [Place]         = []
    var filteredPlaces: [Place] = []
    var isSearching             = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Place>!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureSearchController()
        configureCollectionView()
        getPlaces()
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemCyan
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createTwoColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(PlaceCell.self, forCellWithReuseIdentifier: PlaceCell.reuseID)
    }
    
    private func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for a boba place name"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    
    private func createTwoColumnFlowLayout() -> UICollectionViewFlowLayout {
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
    
    
    private func getPlaces() {
        showLoadingView()
        
        Task {
            do {
                let places = try await NetworkManager.shared.getPlaces(for: zipcode)
                self.places = places
                self.places = []
                updateData(on: self.places)
                updateUI(with: self.places)
                dismissLoadingView()
            } catch {
                if let bfError = error as? BFError {
                    presentBFAlert(title: "Bad stuff happened", message: bfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                dismissLoadingView()
            }
        }
    }
    

    private func updateUI(with places: [Place]) {
        if self.places.isEmpty {
            let message = "No boba places found. Please try another zipcode."
            self.showEmptyStateView(with: message, in: self.view, scaleX: 1, scaleY: 1)
        }
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Place>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, place) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCell.reuseID, for: indexPath) as! PlaceCell
            cell.set(place: place)
            return cell
        })
    }
    
    
    private func updateData(on places: [Place]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Place>()
        snapshot.appendSections([.main])
        snapshot.appendItems(places)
        self.dataSource.apply(snapshot, animatingDifferences:  true)
    }
}


extension PlacesListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray     = isSearching ? filteredPlaces : places
        let place           = activeArray[indexPath.item]
        
        let destVC          = PlaceInfoVC()
        destVC.place        = place
        navigationController?.pushViewController(destVC, animated: true)
    }
}


extension PlacesListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        isSearching = true
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredPlaces.removeAll()
            updateData(on: places)
            return
        }
        
        filteredPlaces = places.filter { $0.name.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredPlaces)
        isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: places)
        isSearching = false
    }
}
