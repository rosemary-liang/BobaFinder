//
//  PlaceCell.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/27/22.
//

import UIKit

class PlaceCell: UICollectionViewCell {
    
    static let reuseID = "PlaceCell"
    
    let iconImageView = BFImageView(frame: .zero)
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
        
//        iconImageView.image = UIImage(named: "no-image-available")
        
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
