//
//  SearchItemVC.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation
import UIKit
import RxSwift

class SearchItemVC: BaseVC {
    @IBOutlet weak var searchItemTextField: UITextField!
    @IBOutlet weak var itemsTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private var items: [SearchItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// - MARK: Setup Methods
private extension SearchItemVC {
    func setupView() {
        setupTextField()
        setupTableView()
        setupAccessibilityId()
    }
    
    func setupTextField() {
        searchItemTextField.delegate = self
        searchItemTextField.placeholder = String(localized: "SEARCH_PRODUCTS")
    }
    
    func setupTableView() {
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.registerCell(type: SearchItemTableViewCell.self)
    }
    
    func setupAccessibilityId() {
        searchItemTextField.accessibilityIdentifier = "searchItemTextField"
        itemsTableView.accessibilityIdentifier = "itemsTableView"
    }
}

// - MARK: Private Methods
private extension SearchItemVC {
    func getItems(with itemName: String? = nil, offset: Int = 0) {
        showLoading(message: String(localized: "SEARCHING_PRODUCTS"))
        SearchItemsManager.shared.getItemsByName(itemName, offset)
            .do(onDispose: { self.hideLoading() })
            .subscribe(onSuccess: { items in
                self.items = (offset != 0) ? self.items + items : items
                self.itemsTableView.reloadData()
            }, onError: { error in
                if let error = error as? SearchError {
                    self.view.showToast(message: error.localizedDescription)
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                        self.showDialogError(withMessage: String(localized: "GENERIC_ERROR"))
                    }
                }
            }).disposed(by: disposeBag)
    }
}

// - MARK: Delegate Methods
extension SearchItemVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let itemToSearch = textField.text, !itemToSearch.isEmpty {
            getItems(with: itemToSearch)
        } else {
            showDialogError(withMessage: String(localized: "TEXT_FIELD_EMPTY_ERROR"))
        }
        return true
    }
}

extension SearchItemVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: SearchItemTableViewCell.self,for: indexPath) as? SearchItemTableViewCell else { return UITableViewCell() }
        cell.bind(with: items[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemDetailVC.instantiate() as ItemDetailVC
        vc.initView(items[indexPath.row])
        pushViewController(with: vc)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = indexPath.row + 1
        if lastIndex == items.count {
            getItems(offset: lastIndex)
        }
    }
}
