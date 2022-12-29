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
    
//    init(tip: Tip) {
//        super.init(frame: .zero)
//        self.tip = tip
//    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
    }
}
