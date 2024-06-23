//
//  ItemDetailVC.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 22/06/24.
//

import Foundation
import UIKit
import RxSwift
import RxAlamofire

class ItemDetailVC: BaseVC {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private var item: SearchItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
        
    func initView(_ item: SearchItem) {
        self.item = item
    }
}


// - MARK: Setup Methods
private extension ItemDetailVC {
    func setupView() {
        guard let item else { return }
        titleLabel.text = item.title
        downloadThumbnail(item.thumbnail)
        priceLabel.text = "\(AppConstants.siteId.pricePrefix) \(item.price.formattedString())"
        
        if let originalPrice = item.originalPrice {
            originalPriceLabel.isHidden = false
            originalPriceLabel.attributedText = String("\(AppConstants.siteId.pricePrefix) \(originalPrice.formattedString() )").strikeThroughText()
        }
        
        stackView.addArrangedSubview(createBuyView())
        stackView.addArrangedSubview(createSellerView(with: item.seller, category: item.categoryId))
        stackView.addArrangedSubview(createProductInfoView(item.attributes.toDictionary()))
    }
    
    func reloadView() {
        showLoading(message: String(localized: "RELOADING"))
        for view in stackView.arrangedSubviews {
            if view.tag != 0 {
                stackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
        setupView()
        hideLoading()
    }
}

// - MARK: Private Methods
private extension ItemDetailVC {
    func downloadThumbnail(_ url: String?) {
        if let url = URL(string: url!) {
            RxAlamofire.requestData(.get, url)
                .subscribe(onNext: { [weak self] ( _, data) in
                    guard let self = self,
                          let image = UIImage(data: data)
                    else { return }
                    self.itemImageView.image = image
                }, onError: { error in
                    print("Error downloading image: \(error)")
                }).disposed(by: disposeBag)
        }
    }
}

// - MARK: Create View Area
private extension ItemDetailVC {
    func createBuyView() -> UIView {
        let containerView = UIView()
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        containerView.addSubview(stackView)
        stackView.fillSuperView()
        
        let addCartButton = createButtonContainer(withTitle: String(localized: "ADD_TO_CART")) {
            self.view.showToast(message: String(localized: "NOT_IMPLEMENTED_YET"))
        }
        
        let buyButton = createButtonContainer(withTitle: String(localized: "BUY_NOW")) {
            self.view.showToast(message: String(localized: "NOT_IMPLEMENTED_YET"))
        }
        
        stackView.addArrangedSubview(addCartButton)
        stackView.addArrangedSubview(buyButton)
        
        containerView.tag = 1
        
        return containerView
    }
    
    func createButtonContainer(withTitle title: String, action: @escaping () -> Void) -> UIView {
        let buttonContainer = UIView()
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .defaultBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.cornerRadius = 15
        button.addAction(UIAction { _ in action() }, for: .touchUpInside)
        
        buttonContainer.addSubview(button)
        button.anchorToEntireView(of: buttonContainer, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
        
        buttonContainer.tag = 1
        
        return buttonContainer
    }
    
    func createSellerView(with sellerInfo: Seller, category: String) -> UIView {
        let containerView = UIView()
        let contentView = UIView()
        contentView.backgroundColor = .defaultGrey
        contentView.layer.cornerRadius = 15
        
        let titleLabel = UILabel()
        titleLabel.text = String(localized: "SELLER_INFO")
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        let sellerLabel = UILabel()
        sellerLabel.text = sellerInfo.nickname
        sellerLabel.textAlignment = .center
        sellerLabel.font = UIFont.systemFont(ofSize: 16)
        
        let moreButton = UIButton(type: .system)
        moreButton.setTitle(String(localized: "SEE_MORE_FROM_SELLER"), for: .normal)
        moreButton.addAction(UIAction { _ in
            let vc = SellerItemsVC()
            vc.initView(with: sellerInfo, category: category) { item in
                self.item = item
                self.reloadView()
            }
            vc.modalPresentationStyle = .formSheet
            self.present(vc, animated: true, completion: nil)
        }, for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(sellerLabel)
        contentView.addSubview(moreButton)
        
        titleLabel.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: nil,
            right: contentView.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        sellerLabel.anchor(
            top: titleLabel.bottomAnchor,
            left: contentView.leftAnchor,
            bottom: nil,
            right: contentView.rightAnchor,
            paddingTop: 8,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        moreButton.anchor(
            top: sellerLabel.bottomAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingTop: 8,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16
        )
        
        containerView.addSubview(contentView)
        contentView.fillSuperView(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        containerView.tag = 1
        
        return containerView
    }
    
    func createProductInfoView(_ infoDict: [String: String]) -> UIView {
        let containerView = UIView()
        let contentView = UIView()
        contentView.backgroundColor = .defaultGrey
        contentView.layer.cornerRadius = 15

        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill

        let titleLabel = UILabel()
        titleLabel.text = String(localized: "PRODUCT_INFO")
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textAlignment = .center
        verticalStackView.addArrangedSubview(titleLabel)
        
        for (key, value) in infoDict {
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = 8
            horizontalStackView.alignment = .top
            horizontalStackView.distribution = .fill

            let keyLabel = UILabel()
            keyLabel.text = key
            keyLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            keyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

            let valueLabel = UILabel()
            valueLabel.text = value
            valueLabel.font = UIFont.systemFont(ofSize: 16)
            valueLabel.numberOfLines = 0
            valueLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
            valueLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

            horizontalStackView.addArrangedSubview(keyLabel)
            horizontalStackView.addArrangedSubview(valueLabel)

            verticalStackView.addArrangedSubview(horizontalStackView)
        }

        contentView.addSubview(verticalStackView)
        verticalStackView.fillSuperView(padding: .init(top: 16, left: 16, bottom: 16, right: 16))

        containerView.addSubview(contentView)
        contentView.fillSuperView(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        containerView.tag = 1

        return containerView
    }
}
