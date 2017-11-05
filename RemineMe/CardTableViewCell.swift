//
//  CardTableViewCell.swift
//  Remine
//
//  Created by Odselmaa Dorjsuren on 10/14/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var card_title: UILabel!
    @IBOutlet weak var card_image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
