//
//  ItemDetailVC.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 22/06/24.
//

import Foundation
import UIKit

class ItemDetailVC: BaseVC {
    
    private var item: SearchItem?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initView(_ item: SearchItem) {
        self.item = item
    }
}

// - MARK: Setup Methods
private extension ItemDetailVC {

}
