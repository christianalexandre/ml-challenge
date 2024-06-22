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
    private var lastSearch = ""
    
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
    func getItems(with itemName: String?, offset: Int = 0) {
        showLoading(message: String(localized: "SEARCHING_PRODUCTS"))
        let itemToSearch = itemName ?? lastSearch
        SearchItemRepository().searchItem(itemToSearch, offset)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(ConcurrentMainScheduler.instance)
            .do(onDispose: { self.hideLoading() })
            .subscribe(onSuccess: { items in
                self.items = (offset != 0) ? self.items + items.results : items.results
                self.lastSearch = itemToSearch
                self.itemsTableView.reloadData()
            }, onError: {_ in
                print("onError")
            }).disposed(by: disposeBag)
    }
}

// - MARK: Delegate Methods
extension DashboardVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getItems(with: textField.text)
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
        let vc = ItemDetailVC()
        vc.initView(items[indexPath.row])
        pushViewController(with: vc)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = indexPath.row + 1
        if lastIndex == items.count {
            getItems(with: lastSearch, offset: lastIndex)
        }
    }
}
