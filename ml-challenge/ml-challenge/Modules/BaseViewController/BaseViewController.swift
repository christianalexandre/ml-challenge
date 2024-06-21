//
//  BaseViewController.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    
    private lazy var loadingView = UIAlertController()
    
    func pushViewController(with viewController: UIViewController, animating animated: Bool = true) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(animating animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }

    func showLoading() {
        let alertController = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        alertController.view.addSubview(loadingIndicator)
        loadingView = alertController
        present(loadingView, animated: true, completion: nil)
    }
    
    func hideLoading(animating animated: Bool = true) {
        loadingView.dismiss(animated: animated)
    }
    
    func showDialogError(withMessage message: String) {
        let alert = UIAlertController(
            title: String(localized: "DIALOG_ERROR"),
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(
            title: String(localized: "DIALOG_OK"),
            style: UIAlertAction.Style.default,
            handler: nil)
        )
        self.present(alert, animated: true, completion: nil)
    }
}

