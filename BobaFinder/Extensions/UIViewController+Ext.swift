//
//  UIViewController+Ext.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

extension UIViewController {
    func presentBFAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = BFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true)
    }
}
