//
//  BFAlertVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

class BFAlertVC: UIViewController {
    
    let containerView   = BFAlertContainerView()
    let titleLabel      = BFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel    = BFBodyLabel(textAlignment: .center)
    let actionButton    =  BFButton(backgroundColor: .systemPink, title: "Ok")

    var alertTitle: String?
    var message: String?
    var buttonTitle:String?
    
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle  = title
        self.message     = message
        self.buttonTitle = buttonTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
