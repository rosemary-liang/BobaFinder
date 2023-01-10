//
//  UIViewController+Ext.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import UIKit

private var containerView: UIView!

extension UIViewController {
    
    func presentBFAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = BFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle   = .crossDissolve
        self.present(alertVC, animated: true)
    }
    
    func presentDefaultError() {
        let alertVC = BFAlertVC(title: "Something went wrong",
                                message: "We were unable to complete your task at this time. Please try again.",
                                buttonTitle: "Ok")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle   = .crossDissolve
        self.present(alertVC, animated: true)
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView, scaleX: Double, scaleY: Double, translateY: Double? = nil) {
        let emptyStateView   = BFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
        
        emptyStateView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            .translatedBy(x: 0, y: translateY ?? 0)
    }
}
