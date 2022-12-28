//
//  BFPlaceInfoHeadVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

class BFPlaceInfoHeadVC: UIViewController {
    
    let placeImage = UIImage()
    let placeNameLabel = BFTitleLabel(textAlignment: .left, fontSize: 30)
    let locationIcon = UIImageView()
    let locationLabel = BFSecondaryTitleLabel(fontSize: 18)
    
    
    var place: Place!
    var image: BFImageView!
    
    init(place: Place) {
        super.init(nibName: nil, bundle: nil)
        self.place = place
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configureUIElements() {
        view.addSubview(placeImage)
        view.addSubview(placeNameLabel)
        view.addSubview(locationIcon)
        view.addSubview(locationLabel)
        
        
    }
    
    
    


}
