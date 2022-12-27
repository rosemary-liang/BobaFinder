//
//  PlacesListVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

class PlacesListVC: UIViewController {
    
    var zipcode: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
        
        
        
        
//        Task {
//            do {
//                let places = try await NetworkManager.shared.getPlaces(for: zipcode, complet)
//                print(places.count)
//                print(places)
//            } catch {
//                if let bfError = error as? BFError {
//                    presentBFAlert(title: "Something bad happened", message: bfError.rawValue, buttonTitle: "Ok")
//                } else {
//                    presentBFAlert(title: "Something bad happened", message: "Uh Oh", buttonTitle: "Ok")
//                }
//
//            }
//
//        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    

}
