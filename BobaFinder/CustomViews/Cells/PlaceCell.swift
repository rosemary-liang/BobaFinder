//
//  PlaceCell.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/27/22.
//

import UIKit

class PlaceCell: UICollectionViewCell {
    
    static let reuseID = "PlaceCell"
    
    var placeImageView = BFImageView(frame: .zero)
    var photos: [Photo] = []
    let nameLabel = BFTitleLabel(textAlignment: .center, fontSize: 16)
    let distanceLabel = BFBodyLabel(textAlignment: .center)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func set(place: Place) {
        nameLabel.text = place.name
        let distanceInMiles: Double = Double(place.distance) / 1_609.344
        distanceLabel.text = "\(String(format: "%.1f", distanceInMiles)) miles"
        
        
        Task {
            placeImageView.getPhotoURLAndSetImage(fsqId: place.fsqID)
        }
//        NetworkManager.shared.getPhotoURLs(for: place.fsqID) { [weak self] result in
//            guard let self else { return }
//
//            switch result {
//            case .success(let photos):
//                self.photos = photos
//
//                guard let photo = self.photos.first else { return }
//                let photoURL = photo.rootPrefix + "original" + photo.suffix
//
//                NetworkManager.shared.downloadImage(from: photoURL) { image in
//                    DispatchQueue.main.async {
//                        self.iconImageView.image = image
//                    }
//                }
//
//            case .failure(_):
//                break
//                #warning("revisit error handling in .failure")
//            }
//        }
    }
    
    func addSubviews() {
        addSubview(placeImageView)
        addSubview(nameLabel)
        addSubview(distanceLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            placeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            placeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            placeImageView.heightAnchor.constraint(equalTo: placeImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            distanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            distanceLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
}
    
