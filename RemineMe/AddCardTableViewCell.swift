//
//  AddCardTableViewCell.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/5/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit

class AddCardTableViewCell: UITableViewCell {
    @IBOutlet var collectionView: CardCollectionViewCell!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
