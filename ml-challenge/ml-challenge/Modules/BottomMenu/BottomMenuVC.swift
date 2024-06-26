//
//  BottomMenuVC.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 25/06/24.
//

import Foundation
import UIKit

protocol CartDelegate {
    func addItemToCart(_ item: SearchItem)
    func updateCartBadge(_ value: String)
}

class BottomMenuVC: UITabBarController {
    private let searchItemVC = SearchItemVC.instantiate()
    private let lastSearchVC = LastSearchVC()
    private let cartVC = CartVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupAppearence()
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

// - MARK: Setup Methods
private extension BottomMenuVC {
    func setupViewControllers() {
        (searchItemVC as? SearchItemVC)?.cartDelegate = self
        lastSearchVC.cartDelegate = self
        cartVC.cartDelegate = self
        
        searchItemVC.tabBarItem = UITabBarItem(title: String(localized: "SEARCH_ITEM_TITLE"), image: UIImage(systemName: "magnifyingglass"), tag: 0)
        lastSearchVC.tabBarItem = UITabBarItem(title: String(localized: "LAST_SEARCH_TITLE"), image: UIImage(systemName: "shared.with.you"), tag: 1)
        cartVC.tabBarItem = UITabBarItem(title: String(localized: "CART_TITLE"), image: UIImage(systemName: "cart"), tag: 2)
        
        self.viewControllers = [searchItemVC, lastSearchVC, cartVC]
    }
    
    func setupAppearence() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .defaultYellow
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        itemAppearance.normal.iconColor = .darkGray
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        itemAppearance.selected.iconColor = .systemBlue
        
        appearance.stackedLayoutAppearance = itemAppearance
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }
}

// - MARK: Delegate Methods
extension BottomMenuVC: CartDelegate {
    func addItemToCart(_ item: SearchItem) {
        cartVC.addItemToCart(item)
    }
    
    func updateCartBadge(_ value: String) {
        let newValue = value == "0" ? nil : value
        tabBar.items?.first(where: { $0.title == String(localized: "CART_TITLE") })?.badgeValue = newValue
    }
}
