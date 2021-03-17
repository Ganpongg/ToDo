//
//  UIViewController+Loading.swift
//  ToDo
//
//  Created by Gantapong Mongkhonkaset on 14/3/2564 BE.
//  Copyright © 2564 BE Gantapong Mongkhonkaset. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {
    func showLoading() {
        let data = ActivityData(size: CGSize(width: 60, height: 60), type: .ballSpinFadeLoader, backgroundColor: UIColor.black.withAlphaComponent(0.2))
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(data)
    }
    
    func hideLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
