//
//  UIViewController+EmptyView.swift
//  ToDo
//
//  Created by Gantapong Mongkhonkaset on 14/3/2564 BE.
//  Copyright © 2564 BE Gantapong Mongkhonkaset. All rights reserved.
//

import UIKit

extension UIViewController {
    func createNoContentView() -> UIView {
        let noContentView = UIView()
        noContentView.isHidden = true
        view.addSubview(noContentView)
        noContentView.translatesAutoresizingMaskIntoConstraints = false
        noContentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        noContentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        noContentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        noContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let noContentLabel = UILabel()
        noContentLabel.text = "Don't have any items"
        noContentLabel.textAlignment = .center
        noContentView.addSubview(noContentLabel)
        noContentLabel.translatesAutoresizingMaskIntoConstraints = false
        noContentLabel.topAnchor.constraint(equalTo: noContentView.topAnchor).isActive = true
        noContentLabel.leftAnchor.constraint(equalTo: noContentView.leftAnchor).isActive = true
        noContentLabel.rightAnchor.constraint(equalTo: noContentView.rightAnchor).isActive = true
        noContentLabel.bottomAnchor.constraint(equalTo: noContentView.bottomAnchor).isActive = true
        
        return noContentView
    }
    
    func showNoContentView(_ noContentView: UIView) {
        noContentView.superview?.bringSubviewToFront(noContentView)
        noContentView.isHidden = false
    }
    
    func hideNoContentView(_ noContentView: UIView) {
        noContentView.isHidden = true
    }
}
