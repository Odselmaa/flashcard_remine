//
//  MyCollectionTableViewCell.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/21/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit

class MyCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var iv_cover: CardCover!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_desc: UILabel!
    @IBOutlet weak var lbl_count: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
