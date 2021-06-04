//
//  TableViewCell.swift
//  WishList
//
//  Created by 김태균 on 2021/05/30.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var nameField: UILabel!
    @IBOutlet var priceField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.layer.cornerRadius = 12
        photoImageView.backgroundColor = .systemPink
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// https://www.youtube.com/watch?v=WK5vrOD1zCQ
