//
//  TipCell.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/28/22.
//

import UIKit

class TipCell: UICollectionViewCell {
    
    static let reuseId  = "TipCell"

    let tipLabel        = BFTipLabel(textAlignment: .center)
    let timestampLabel  = BFBodyLabel(textAlignment: .left)

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(tip: Tip) {
        tipLabel.text = tip.text
        tipLabel.lineBreakMode = .byWordWrapping
        tipLabel.numberOfLines = 3
        let dateString = String(tip.createdAt)
        timestampLabel.text = formatDate(dateString: dateString)
    }
    
    private func formatDate(dateString: String) -> String {
        let date = dateString
          
        let formatter1        = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter1.locale     = Locale(identifier: "en_US_POSIX")
          
        if let date2 = formatter1.date(from: date) {
            let formatter2          = DateFormatter()
            formatter2.dateFormat   = "MMM yyyy"
            formatter2.locale       = Locale(identifier: "en_US_POSIX")
            
            let newDateString       = formatter2.string(from: date2)
            return newDateString
        }
        return ""
    }
    
    private func addSubviews() {
        addSubview(tipLabel)
        addSubview(timestampLabel)
    }
    
    private func layoutUI() {

        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            tipLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            tipLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding + 15),
            tipLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding - 15),
            tipLabel.heightAnchor.constraint(equalToConstant: 80),
            
            timestampLabel.topAnchor.constraint(equalTo: tipLabel.bottomAnchor, constant: padding),
            timestampLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            timestampLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            timestampLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
        
    }
}
