//
//  UIView+Ext.swift
//  BobaFinder
//
//  Created by Eric Liang on 1/4/23.
//

import UIKit

extension UIView {
    // to find parent VC
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
            
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
            
        } else {
            return nil
        }
    }
}
