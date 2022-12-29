//
//  TipCell.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

class TipCell: UICollectionViewCell {
    
    static let reuseId = "TipCell"

    let tipLabel = BFTipLabel(textAlignment: .center)
    let timestampLabel = BFBodyLabel(textAlignment: .left)
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(tip: Tip) {
        tipLabel.text = tip.text
        timestampLabel.text = tip.createdAt
    }
    
    private func configure() {
        addSubview(tipLabel)
        addSubview(timestampLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            tipLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            tipLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            tipLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            tipLabel.heightAnchor.constraint(equalToConstant: 90),
            
            timestampLabel.topAnchor.constraint(equalTo: tipLabel.bottomAnchor, constant: padding),
            timestampLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            timestampLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            timestampLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
        
    }
}
