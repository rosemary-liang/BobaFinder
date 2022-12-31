//
//  BFPlaceInfoHeadVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

class BFPlaceInfoHeadVC: UIViewController {
    
    let placeImageView = BFImageView(frame: .zero)
    let placeNameLabel = BFTitleLabel(textAlignment: .left, fontSize: 35)
    let distanceLabel = BFBodyLabel(textAlignment: .left)
    let locationLabel = BFSecondaryTitleLabel(textAlignment: .left, fontSize: 18)
    
    var place: Place!
   
    
    init(place: Place) {
        super.init(nibName: nil, bundle: nil)
        self.place = place
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureUIElements()
        layoutUI()
    }
    
    func setPhoto() {
        Task {
            placeImageView.getPhotoURLAndSetImage(fsqId: place.fsqID)
        }
    }

    
    func addSubviews() {
        view.addSubview(placeImageView)
        view.addSubview(placeNameLabel)
        view.addSubview(distanceLabel)
        view.addSubview(locationLabel)
    }
    
    
    func configureUIElements() {
        setPhoto()
        
        placeNameLabel.text         = place.name
        
        let distanceInMiles         = Double(place.distance) / 1_609.344
        distanceLabel.text          = "\(String(format: "%.1f", distanceInMiles)) miles away"
        
        locationLabel.text          = "\(place.location.address)\n\(place.location.locality), \(place.location.region)"
        locationLabel.numberOfLines = 3
    }
    
    
    func layoutUI() {
        let padding: CGFloat        = 20
        let imagePadding: CGFloat   = 16
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            placeNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            placeNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            placeNameLabel.heightAnchor.constraint(equalToConstant: 45),
            
            placeImageView.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: padding),
            placeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            placeImageView.widthAnchor.constraint(equalToConstant: 140),
            placeImageView.heightAnchor.constraint(equalToConstant: 140),
            

            locationLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: padding + 10),
            locationLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: imagePadding),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            locationLabel.heightAnchor.constraint(equalToConstant: 60),
            
            distanceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: -padding),
            distanceLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: imagePadding),
            distanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            distanceLabel.bottomAnchor.constraint(equalTo: placeImageView.bottomAnchor),
        ])
    }
}

