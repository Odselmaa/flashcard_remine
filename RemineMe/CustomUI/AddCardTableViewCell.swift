//
//  AddCardTableViewCell.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/5/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit

class AddCardTableViewCell: UITableViewCell{
    @IBOutlet weak var lbl_card: UILabel!
    
    @IBOutlet weak var lbl_rear: UILabel!
    var front_text: String = "Hey Soul Sister"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

//extension AddCardTableViewCell: UITableViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "front_card", for:indexPath) as! CardCollectionViewCell
//        cell.lbl_front.text = front_text
//        return cell
//    }
//}
