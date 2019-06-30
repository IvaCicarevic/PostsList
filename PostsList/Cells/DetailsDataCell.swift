//
//  DetailsDataCell.swift
//  PostsList
//
//  Created by Iva Cicarevic on 5/30/19.
//  Copyright © 2019 Iva Cicarevic. All rights reserved.
//

import UIKit

class DetailsDataCell: UITableViewCell {

    //MARK: -outlets
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailBody: UILabel!
    
    
    //MARK: -vars
    var datas: Detail? {
        didSet {
            configureCell()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailBody.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - configure cell
    private func configureCell() {
        
        guard let datas = datas else { return }
        detailTitle.text = datas.name
        detailBody.text = datas.body
    }
}
