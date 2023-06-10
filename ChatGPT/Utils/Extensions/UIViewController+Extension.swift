//
//  UIViewController+Extension.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 09/06/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func hideKeyboardwhenTappedAround () {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector (UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func addLogoTofavigationBarItem(image: UIImage) {
        let imageView = UIImageView ()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant:110).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        let contentView = UIView()
        navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo:contentView.centerXAnchor).isActive=true
        imageView.centerYAnchor.constraint(equalTo:contentView.centerYAnchor).isActive=true
    }
    
}
