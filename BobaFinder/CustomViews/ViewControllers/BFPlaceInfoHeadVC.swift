//
//  BFPlaceInfoHeadVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

class BFPlaceInfoHeadVC: UIViewController {
    
    let placeImageView = BFImageView(frame: .zero)
    let placeNameLabel = BFTitleLabel(textAlignment: .left, fontSize: 30)
    let distanceLabel = BFBodyLabel(textAlignment: .left)
    let locationLabel = BFSecondaryTitleLabel(fontSize: 18)
    
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
        // dupe function from PlaceCell.. try to refactor later
        NetworkManager.shared.getPhotoURLs(for: place.fsqID) { result in
            switch result {
            case .success(let photos):

                guard let photo = photos.first else { return }
                let photoURL = photo.rootPrefix + "original" + photo.suffix

                NetworkManager.shared.downloadImage(from: photoURL) { image in
                    DispatchQueue.main.async {
                        self.placeImageView.image = image
                    }
                }

            case .failure(_):
                break
                #warning("revisit error handling in .failure")
            }
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
        
        let distanceInMiles: Double = Double(place.distance) / 1_609.344
        distanceLabel.text = "\(String(format: "%.1f", distanceInMiles)) miles"
        
        locationLabel.text          = "\(place.location.address)\n\(place.location.locality), \(place.location.region)"
        locationLabel.numberOfLines = 3
    }
    
    
    func layoutUI() {
        let padding: CGFloat        = 25
        let imagePadding: CGFloat   = 14
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        #warning("trailing anchors have issue - revisit later")
        NSLayoutConstraint.activate([
            placeNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            placeNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding), //this?
//            placeNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            placeNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            placeImageView.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: padding),
            placeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            placeImageView.widthAnchor.constraint(equalToConstant: 120),
            placeImageView.heightAnchor.constraint(equalToConstant: 120),
            

            locationLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: padding + 10),
            locationLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: imagePadding),
//            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            locationLabel.heightAnchor.constraint(equalToConstant: 60),
            
            distanceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: -padding),
            distanceLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: imagePadding),
//            distanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            distanceLabel.bottomAnchor.constraint(equalTo: placeImageView.bottomAnchor),
        ])
    }
}

