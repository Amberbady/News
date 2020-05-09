//
//  MyOtherCell.swift
//  News
//
//  Created by liaoshen on 2020/5/8.
//  Copyright © 2020 liaoshen. All rights reserved.
//

import UIKit

class MyOtherCell: UITableViewCell , RegisterCellOrNib {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        /// 设置主题
//        leftLabel.theme_textColor = "colors.black"
//        rightLabel.theme_textColor = "colors.cellRightTextColor"
//        rightImageView.theme_image = "images.cellRightArrow"
//        separatorView.theme_backgroundColor = "colors.separatorViewColor"
//        theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
