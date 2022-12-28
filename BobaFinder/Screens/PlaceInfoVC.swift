//
//  PlaceInfoVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

class PlaceInfoVC: UIViewController {
    
    var place: Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        print(place.name)
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
