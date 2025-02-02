//
//  UITableView+Extension.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(ofType cellClass: T.Type) {
            let identifier = String(describing: cellClass)
            
            // for nib
            let nib = UINib(nibName: identifier, bundle: nil)
            if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
                register(nib, forCellReuseIdentifier: identifier)
            } else {
                // class
                register(cellClass, forCellReuseIdentifier: identifier)
            }
        }
    
    func dequeueReusableCell<T: UITableViewCell>(ofType cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.cellIdentifier, for: indexPath) as? T
    }
}

extension UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
