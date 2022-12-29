//
//  PlaceCell.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/27/22.
//

import UIKit

class PlaceCell: UICollectionViewCell {
    
    static let reuseID = "PlaceCell"
    
    var iconImageView = BFImageView(frame: .zero)
    var photos: [Photo] = []
    let nameLabel = BFTitleLabel(textAlignment: .center, fontSize: 16)
    let distanceLabel = BFBodyLabel(textAlignment: .center)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    func set(place: Place) {
        nameLabel.text = place.name
        let distanceInMiles: Double = Double(place.distance) / 1_609.344
        distanceLabel.text = "\(String(format: "%.1f", distanceInMiles)) miles"
        
        NetworkManager.shared.getPhotoURLs(for: place.fsqID) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let photos):
                self.photos = photos
                
                guard let photo = self.photos.first else { return }
                let photoURL = photo.rootPrefix + "original" + photo.suffix
                
                NetworkManager.shared.downloadImage(from: photoURL) { image in
                    DispatchQueue.main.async {
                        self.iconImageView.image = image
                    }
                }
                
            case .failure(_):
                break
#warning("revisit error handling in .failure")
            }
        }
    }
        
        
        private func configure() {
            addSubview(iconImageView)
            addSubview(nameLabel)
            addSubview(distanceLabel)
            
            let padding: CGFloat = 8
            
            NSLayoutConstraint.activate([
                iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
                iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
                
                nameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 12),
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
    
