//
//  DashboardVC.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation
import UIKit
import RxSwift

class DashboardVC: BaseVC {
    @IBOutlet weak var searchItemTextField: UITextField!
    @IBOutlet weak var itemsTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private var items: [SearchItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
private extension DashboardVC {
    func setupView() {
        setupTextField()
        setupTableView()
    }
    
    func setupTextField() {
        searchItemTextField.delegate = self
        searchItemTextField.placeholder = String(localized: "SEARCH_PRODUCTS")
    }
    
    func setupTableView() {
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.registerCell(type: SearchItemCell.self)
    }
}

// - MARK: Private Methods
private extension DashboardVC {
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
extension DashboardVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let itemToSearch = textField.text, !itemToSearch.isEmpty {
            getItems(with: itemToSearch)
        } else {
            showDialogError(withMessage: String(localized: "TEXT_FIELD_EMPTY_ERROR"))
        }
        return true
    }
}

extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: SearchItemCell.self,for: indexPath) as? SearchItemCell else { return UITableViewCell() }
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
