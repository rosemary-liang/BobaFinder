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
    let locationIcon = UIImageView()
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
        view.addSubview(locationIcon)
        view.addSubview(locationLabel)
    }
    
    
    func configureUIElements() {
        setPhoto()
        placeNameLabel.text     = place.name
        locationLabel.text      = "\(place.location.formattedAddress)"
        locationIcon.image      = UIImage(systemName: "mappin.and.ellipse")
        locationIcon.tintColor  = .secondaryLabel
    }
    
    
    func layoutUI() {
        let padding: CGFloat        = 5
        let imagePadding: CGFloat   = 5
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            placeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            placeImageView.widthAnchor.constraint(equalToConstant: 100),
            placeImageView.heightAnchor.constraint(equalToConstant: 100),
            
            placeNameLabel.topAnchor.constraint(equalTo: placeImageView.topAnchor),
            placeNameLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: imagePadding),
            placeNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            placeNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            locationIcon.bottomAnchor.constraint(equalTo: placeImageView.bottomAnchor),
            locationIcon.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: imagePadding),
            locationIcon.widthAnchor.constraint(equalToConstant: 20), // this
            locationIcon.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor), // this
            locationLabel.heightAnchor.constraint(equalToConstant: 40)
        
        ])
    }
    
    


}
