//
//  FavoriteCell.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/30/22.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = "FavoriteCell"
    let placeImageView = BFImageView(frame: .zero)
    let placeNameLabel = BFTitleLabel(textAlignment: .left, fontSize: 24)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addSubviews() {
        addSubview(placeImageView)
        addSubview(placeNameLabel)
    }
    
    
    private func layoutUI() {
        accessoryType                = .disclosureIndicator // tappable to present new content
        let padding: CGFloat         = 12
        
        NSLayoutConstraint.activate([
            placeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            placeImageView.heightAnchor.constraint(equalToConstant: 70),
            placeImageView.widthAnchor.constraint(equalToConstant: 70),
            
            placeNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeNameLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: padding),
            placeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            placeNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func set(favorite: Place) {
        placeNameLabel.text = favorite.name
        
        Task {
//            placeImageView.getPhotoURLAndSetImage(fsqId: favorite.fsqID)
            placeImageView.getPhotoURLAndSetImage(name: favorite.name, fsqId: favorite.fsqID)
        }
    }
    
    
 
    
}
