//
//  PlacesListVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

class PlacesListVC: UIViewController {
    
    var zipcode: String!
    var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        configureViewController()
        configureCollectionView()
        getPlaces()
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(PlaceCell.self, forCellWithReuseIdentifier: PlaceCell.reuseID)
    }
    
    
    func getPlaces() {
        NetworkManager.shared.getPlaces(for: zipcode) { result in
            switch result {
            case .success(let places):
                print(places)
               
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentBFAlert(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    }
}
