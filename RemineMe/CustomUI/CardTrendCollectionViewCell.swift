//
//  CardTrendCollectionViewCell.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/26/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit

class CardTrendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iv_cover: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    
    override func draw(_ rect: CGRect) {
        let shadowPath = UIBezierPath(rect: iv_cover.bounds)
        iv_cover.layer.shadowColor = UIColor.gray.cgColor
        iv_cover.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        iv_cover.layer.shadowOpacity = 0.2
        iv_cover.layer.shadowRadius = 4
        iv_cover.layer.cornerRadius = 10
        iv_cover.layer.masksToBounds = false
        iv_cover.layer.shadowPath = shadowPath.cgPath
    }
    
}
