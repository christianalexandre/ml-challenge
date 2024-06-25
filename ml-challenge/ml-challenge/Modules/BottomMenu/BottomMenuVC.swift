//
//  BottomMenuVC.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 25/06/24.
//

import Foundation
import UIKit

class BottomMenuVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchItemVC = SearchItemVC.instantiate()
        searchItemVC.tabBarItem = UITabBarItem(title: String(localized: "SEARCH_ITEM_TITLE"), image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let lastSearchVC = LastSearchVC()
        lastSearchVC.tabBarItem = UITabBarItem(title: String(localized: "LAST_SEARCH_TITLE"), image: UIImage(systemName: "shared.with.you"), tag: 1)
        
        let cartVC  = UIViewController()
        cartVC.view.backgroundColor = .defaultYellow
        cartVC.tabBarItem = UITabBarItem(title: String(localized: "CART_TITLE"), image: UIImage(systemName: "cart"), tag: 2)
        
        self.viewControllers = [searchItemVC, lastSearchVC, cartVC]
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .defaultYellow
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.blue]
        
        appearance.stackedLayoutAppearance = itemAppearance
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
