//
//  PostDataCell.swift
//  PostsList
//
//  Created by Iva Cicarevic on 5/29/19.
//  Copyright © 2019 Iva Cicarevic. All rights reserved.
//

import UIKit

class PostDataCell: UITableViewCell {

    //MARK: -outlets
    @IBOutlet weak var postTitle: UILabel!
    
    var datas: UserPost? {
        didSet {
            configureCell()
        }
    }
    
     // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        postTitle.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - configure cell
    private func configureCell() {
        
        guard let datas = datas else { return }
        if let userId = datas.userId {
        
        }
        
        postTitle.text = datas.title
    }
    
}
