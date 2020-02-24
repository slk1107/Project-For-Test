//
//  MainTableCell.swift
//  Project for Test
//
//  Created by Kris on 2020/2/24.
//  Copyright © 2020 Kris. All rights reserved.
//

import UIKit
protocol MainTableCell: UITableViewCell {
    var titleLabel: UILabel! { get set }
    var thumbnailView: UIImageView! { get set }
    var data: UISiteInfo! { get set }
}
