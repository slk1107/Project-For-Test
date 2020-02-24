//
//  DescriptionTableViewCell.swift
//  Project for Test
//
//  Created by Kris on 2020/2/24.
//  Copyright © 2020 Kris. All rights reserved.
//

import UIKit
import Kingfisher
class DescriptionTableViewCell: UITableViewCell, MainTableCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnailView: UIImageView!
    var data: UISiteInfo! {
        didSet {
            titleLabel.text = data.title
            thumbnailView.kf.setImage(with: data.imageURL)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
