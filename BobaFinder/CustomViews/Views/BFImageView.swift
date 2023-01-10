//
//  BFImageView.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/27/22.
//

import UIKit

class BFImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "no-image-available")
   
    var photoURL: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func getPhotoURLAndSetImage(name: String, fsqId: String) {

        Task {
            let photos = try await NetworkManager.shared.getPhotoURLs(for: fsqId)
            guard let photo = photos.first else {
                image = placeholderImage
                return }
            
            self.photoURL = photo.rootPrefix + "original" + photo.suffix
            self.photoURL = photoURL
            image = await NetworkManager.shared.downloadImage(from: self.photoURL!) ?? placeholderImage
        }
    }
}
