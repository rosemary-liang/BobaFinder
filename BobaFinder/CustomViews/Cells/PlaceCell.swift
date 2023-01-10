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
    let placeNameLabel = BFTitleLabel(textAlignment: .center, fontSize: 16)
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
        placeNameLabel.text = place.name
        let distanceInMiles: Double = Double(place.distance) / 1_609.344
        distanceLabel.text = "\(String(format: "%.1f", distanceInMiles)) miles"
        
        Task {
            placeImageView.getPhotoURLAndSetImage(name: place.name, fsqId: place.fsqID)
        }
    }
    
    private func addSubviews() {
        addSubview(placeImageView)
        addSubview(placeNameLabel)
        addSubview(distanceLabel)
    }
    
    private func layoutUI() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            placeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            placeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            placeImageView.heightAnchor.constraint(equalTo: placeImageView.widthAnchor),
            
            placeNameLabel.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: 12),
            placeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            placeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            placeNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            distanceLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 2),
            distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            distanceLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
}
    
