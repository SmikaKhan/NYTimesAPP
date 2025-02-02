//
//  UIVIewController+Extension.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import UIKit

extension UIViewController {
    public func showAlert(title: String,message: String, handler: ((UIAlertAction)->Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    private var activityIndicatorTag: Int { return 999999 }
    
    func showActivityIndicator() {
        // Ensure the activity indicator is not already added
        guard view.viewWithTag(activityIndicatorTag) == nil else { return }
        
        // Create the activity indicator
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tag = activityIndicatorTag
        
        // Add it to the view (not the table view)
        view.addSubview(activityIndicator)
        
        // Center the activity indicator
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Bring the activity indicator to the front
        view.bringSubviewToFront(activityIndicator)
        
        // Start animating
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        // Find the activity indicator by its tag and remove it
        if let activityIndicator = view.viewWithTag(activityIndicatorTag) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
