//
//  SearchItemCell.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 21/06/24.
//

import Foundation
import UIKit
import RxSwift
import RxAlamofire

class SearchItemCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var loadingThumbnailIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var badgesView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        changeThumbnailVisibility(isHidden: true)
    }
    
    func bind(with data: SearchItem) {
        changeThumbnailVisibility(isHidden: true)
        downloadThumbnail(data.thumbnail)
        loadingThumbnailIndicator.startAnimating()
        titleLabel.text = data.title
        detailLabel.text = "\(AppConstants.siteId.pricePrefix) \(data.price.formattedString())"
    }
}

// - MARK: Private Methods
private extension SearchItemCell {
    func downloadThumbnail(_ url: String) {
        SearchItemsManager.shared.downloadThumnail(from: url)
            .subscribe(onSuccess: { [weak self] data in
                self?.changeThumbnailVisibility(isHidden: false)
                self?.thumbnailImageView.image = UIImage(data: data)
            }, onError: { [weak self] error in
                self?.superview?.showToast(message: error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func changeThumbnailVisibility(isHidden: Bool) {
        thumbnailImageView.isHidden = isHidden
        loadingThumbnailIndicator.isHidden = !isHidden
        !isHidden ? loadingThumbnailIndicator.startAnimating() : loadingThumbnailIndicator.stopAnimating()
    }
}


