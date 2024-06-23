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

    func showLoading(message: String = String(localized: "LOADING_DEFAULT")) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.startAnimating()
        alertController.view.addSubview(loadingIndicator)
        let constraints = [
            loadingIndicator.centerYAnchor.constraint(equalTo: alertController.view.centerYAnchor),
            loadingIndicator.rightAnchor.constraint(equalTo: alertController.view.rightAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
        loadingView = alertController
        present(alertController, animated: true, completion: nil)
    }
    
    func hideLoading(animating animated: Bool = true) {
        loadingView.dismiss(animated: animated)
    }
    
    func showDialogError(withMessage message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: String(localized: "DIALOG_ERROR"),
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(
            title: String(localized: "DIALOG_OK"),
            style: UIAlertAction.Style.default,
            handler: { _ in completion?() })
        )
        self.present(alert, animated: true, completion: nil)
    }
}

