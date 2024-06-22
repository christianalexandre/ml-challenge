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

struct SearchItemCellModel {
    let imageURL: String
    let title: String
    let price: String
}

class SearchItemCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(with data: SearchItemCellModel) {
        titleLabel.text = data.title
        detailLabel.text = data.price
        
        downloadThumbnail(data.imageURL)
    }
    
    private func downloadThumbnail(_ url: String) {
        if let url = URL(string: url) {
            RxAlamofire.requestData(.get, url)
                .subscribe(onNext: { [weak self] (response, data) in
                    guard let self = self else { return }
                    if let image = UIImage(data: data) {
                        self.thumbnailImageView.image = image
                    }
                }, onError: { error in
                    print("Error downloading image: \(error)")
                })
                .disposed(by: disposeBag)
        }
    }
}
