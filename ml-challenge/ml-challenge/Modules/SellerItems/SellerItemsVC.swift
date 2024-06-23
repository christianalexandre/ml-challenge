//
//  SellerItemsVC.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 23/06/24.
//

import Foundation
import UIKit
import RxSwift

class SellerItemsVC: BaseVC {
    private let tableView = UITableView()
    private var searchInfoPair: (sellerInfo: Seller, category: String)?
    private var onSelectItemCallback: ((SearchItem) -> Void)?
    private var items: [SearchItem] = []
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showLoading(message: String(localized: "LOADING_SELLER_ITEMS"))
        getItems()
    }
    
    func initView(with sellerInfo: Seller, category: String, onSelectItem: @escaping (SearchItem) -> Void) {
        self.searchInfoPair = (sellerInfo, category)
        self.onSelectItemCallback = onSelectItem
    }
}

// - MARK: Setup Methods
private extension SellerItemsVC {
    func setupView() {
        view.addSubview(tableView)
        tableView.fillSuperView()
            
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerCell(type: SearchItemCell.self)
    }
}

// - MARK: Private Methods
private extension SellerItemsVC {
    func getItems() {
        guard let searchInfoPair else { return }
        SearchItemsManager.shared.searchBySellerId(String(searchInfoPair.sellerInfo.id), searchInfoPair.category)
            .do(onDispose: { self.hideLoading() })
            .subscribe(onSuccess: { [weak self] items in
                self?.items = items
                self?.tableView.reloadData()
            }, onError: { [weak self] error in
                if let error = error as? SearchError {
                    self?.view.showToast(message: error.localizedDescription)
                    self?.dismiss(animated: true)
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                        self?.showDialogError(withMessage: String(localized: "GENERIC_ERROR")) {
                            self?.dismiss(animated: true)
                        }
                    }
                }
            }).disposed(by: disposeBag)
    }
}

// - MARK: Delegate Methods
extension SellerItemsVC: UITableViewDelegate, UITableViewDataSource {
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
        dismiss(animated: true) {
            self.onSelectItemCallback?(self.items[indexPath.row])
        }
    }
}
