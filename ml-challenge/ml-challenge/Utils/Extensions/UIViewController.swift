//
//  Extensions.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation
import UIKit

extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var sceneDelegate: SceneDelegate {
        return UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    }
    
    class func instantiate<T: UIViewController>() -> T {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: identifier.replacingOccurrences(of: "VC", with: ""), bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
