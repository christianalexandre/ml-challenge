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
        detailLabel.text = "R$ \(data.price)"
    }
}

// - MARK: Private Methods
private extension SearchItemCell {
    func downloadThumbnail(_ url: String) {
        if let url = URL(string: url) {
            RxAlamofire.requestData(.get, url)
                .subscribe(onNext: { [weak self] ( _, data) in
                    guard let self = self,
                          let image = UIImage(data: data)
                    else { return }
                    changeThumbnailVisibility(isHidden: false)
                    self.thumbnailImageView.image = image
                }, onError: { error in
                    print("Error downloading image: \(error)")
                }).disposed(by: disposeBag)
        }
    }
    
    func changeThumbnailVisibility(isHidden: Bool) {
        thumbnailImageView.isHidden = isHidden
        loadingThumbnailIndicator.isHidden = !isHidden
        !isHidden ? loadingThumbnailIndicator.startAnimating() : loadingThumbnailIndicator.stopAnimating()
    }
}


