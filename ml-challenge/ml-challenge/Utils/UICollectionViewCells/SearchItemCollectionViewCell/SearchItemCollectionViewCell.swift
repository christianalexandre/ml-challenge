//
//  SearchItemCollectionViewCell.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 25/06/24.
//

import UIKit
import RxSwift

class SearchItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadingThumbnailIndicator: UIActivityIndicatorView!
    @IBOutlet weak var priceLabel: UILabel!
    
    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        changeThumbnailVisibility(isHidden: true)
    }
    
    func bind(with data: SearchItem) {
        self.applyBorder()
        changeThumbnailVisibility(isHidden: true)
        downloadThumbnail(data.thumbnail)
        loadingThumbnailIndicator.startAnimating()
        titleLabel.text = data.title
        priceLabel.text = "\(AppConstants.siteId.pricePrefix) \(data.price.formattedString())"
    }
}

// - MARK: Private Methods
private extension SearchItemCollectionViewCell {
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

