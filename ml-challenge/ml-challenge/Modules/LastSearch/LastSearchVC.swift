//
//  LastSearchVC.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 25/06/24.
//

import Foundation
import UIKit
import RxSwift

class LastSearchVC: BaseVC {
    private let disposeBag = DisposeBag()
    private var items: [SearchItem] = []
    private var categoryDisplaying: String?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "LAST_SEARCH_TITLE")
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(type: SearchItemCollectionViewCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getItemsIfNeeded()
    }
}

// - MARK: Setup Methods
private extension LastSearchVC {
    func setupView() {
        view.addSubview(titleLabel)
        
        let containerCollection = UIView()
        containerCollection.backgroundColor = .white
        containerCollection.addSubview(collectionView)
        
        view.addSubview(containerCollection)
        view.backgroundColor = .defaultYellow
        
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
        
        collectionView.anchorToEntireView(
            of: containerCollection,
            paddingTop: 16,
            paddingLeft: 16,
            paddingBottom: 0,
            paddingRight: 16
        )
    }
    
    func getItemsIfNeeded() {
        if let lastSearch = UserDefaultsHelper.shared.getString(forKey: .lastSearchCategory) {
            if lastSearch != categoryDisplaying {
                getItems(with: lastSearch)
            }
        } else {
            let uiLabel = UILabel()
            uiLabel.text = String(localized: "NOT_SEARCHED_YET")
            uiLabel.textAlignment = .center
            view.addSubview(uiLabel)
            uiLabel.centerToSuperView()
            uiLabel.anchorToEntireView(of: view, padding: 16)
        }
    }
}

// - MARK: Private Methods
private extension LastSearchVC {
    func getItems(with category: String, offset: Int = 0) {
        showLoading(message: String(localized: "SEARCHING_PRODUCTS"))
        SearchItemsManager.shared.searchByCategory(category, offset)
            .do(onDispose: { self.hideLoading() })
            .subscribe(onSuccess: { items in
                self.items = (offset != 0) ? self.items + items : items
                self.categoryDisplaying = items.first?.categoryId
                self.collectionView.reloadData()
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

// MARK: - Delegate Methods
extension LastSearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(withType: SearchItemCollectionViewCell.self,for: indexPath) as? SearchItemCollectionViewCell else { return UICollectionViewCell() }
        cell.bind(with: items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ItemDetailVC.instantiate() as ItemDetailVC
        vc.initView(items[indexPath.row])
        pushViewController(with: vc)
    }
}

extension LastSearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 16, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastIndex = indexPath.item + 1
        if let categoryDisplaying, lastIndex == items.count {
            getItems(with: categoryDisplaying)
        }
    }
}
