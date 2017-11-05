//
//  FavTableViewCell.swift
//  Remine
//
//  Created by Odselmaa Dorjsuren on 10/25/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit


class FavTableViewCell: UITableViewCell {
    @IBOutlet weak var iv_fav: UIImageView?
    @IBOutlet weak var pb_fav: UIProgressView?
    @IBOutlet weak var lbl_fav: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        pb_fav?.transform = CGAffineTransform(scaleX: 1, y: 3)
        pb_fav?.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

