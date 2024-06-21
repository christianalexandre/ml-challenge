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
}

// - MARK: Setup Methods
private extension DashboardVC {
    func setupView() {
        setupTextField()
        setupTableView()
    }
    
    func setupTextField() {
        searchItemTextField.delegate = self
        searchItemTextField.placeholder = "Buscar seu produto"
    }
    
    func setupTableView() {
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.registerCell(type: SearchItemCell.self)
    }
}

private extension DashboardVC {
    func getItems(with itemName: String) {
        SearchItemRepository().searchItem(itemName)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(ConcurrentMainScheduler.instance)
            .subscribe(onSuccess: { items in
                print("success")
                self.items = items.results
                self.itemsTableView.reloadData()
            }, onError: {_ in
                print("onError")
            }).disposed(by: disposeBag)
    }
}

// - MARK: Delegate Methods
extension DashboardVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        getItems(with: textField.text ?? "")
        return true
    }
}

extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: SearchItemCell.self,for: indexPath) as? SearchItemCell else { return UITableViewCell() }
        cell.bind(teste: items[indexPath.row].title)
        return cell
    }
}
