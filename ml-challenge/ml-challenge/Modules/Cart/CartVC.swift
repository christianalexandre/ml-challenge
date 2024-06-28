//
//  CartVC.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 25/06/24.
//

import Foundation
import UIKit

class CartVC: BaseVC {
    typealias CartItems = [(item: SearchItem?, qty: Int)]
    
    var cartDelegate: CartDelegate?
    private var items: [SearchItem] = [] {
        didSet {
            updateLayout()
        }
    }
    private var cartItems: CartItems {
        Dictionary(grouping: items, by: { $0.id })
            .sorted(by: { $0.key < $1.key })
            .map { itemsDict in
                (itemsDict.value.first, itemsDict.value.count)
            }
    }
    private var categoryDisplaying: String?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "CART_TITLE")
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private let noItemsLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "NO_ITEMS_ON_CART")
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(type: SearchItemTableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLayout()
        tableView.reloadData()
    }
}

// - MARK: Setup Methods
private extension CartVC {
    func setupView() {
        view.addSubview(titleLabel)
        
        let containerCollection = UIView()
        containerCollection.backgroundColor = .white
        containerCollection.addSubview(tableView)
        
        view.addSubview(containerCollection)
        view.backgroundColor = .defaultYellow
        view.addSubview(noItemsLabel)
                        
        titleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: nil,
            right: view.safeAreaLayoutGuide.rightAnchor,
            height: 50
        )

        containerCollection.anchor(
            top: titleLabel.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
        
        tableView.anchorToEntireView(
            of: containerCollection,
            paddingTop: 16,
            paddingLeft: 16,
            paddingBottom: 0,
            paddingRight: 16
        )
        
        noItemsLabel.centerToSuperView()
        noItemsLabel.anchorToEntireView(of: view, padding: 16)
    }
    
    func updateLayout() {
        cartDelegate?.updateCartBadge(String(items.count))
        noItemsLabel.isHidden = !items.isEmpty
        tableView.isHidden = items.isEmpty
    }
}

// - MARK: Private Methods
private extension CartVC {

}

// - MARK: Public Methods
extension CartVC {
    func addItemToCart(_ item: SearchItem) {
        items.append(item)
    }
}

// MARK: - Delegate Methods
extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: SearchItemTableViewCell.self,for: indexPath) as? SearchItemTableViewCell else { return UITableViewCell() }
        let item = cartItems[indexPath.row]
        if let unwrapItem = item.item {
            cell.bind(with: unwrapItem, qty: item.qty)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.showToast(message: String(localized: "NOT_IMPLEMENTED_YET"))
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: String(localized: "REMOVE_FROM_CART")
        ) { (_, _, completionHandler) in
            let idToRemove = self.cartItems[indexPath.row].item?.id
            self.items.removeAll(where: { $0.id == idToRemove })
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
