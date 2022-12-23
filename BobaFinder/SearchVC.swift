//
//  SearchVC.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

class SearchVC: UIViewController {
    
    var actionButton = BFButton(backgroundColor: .systemIndigo, title: "Find Boba")

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.addSubview(actionButton)
    }
    


}
