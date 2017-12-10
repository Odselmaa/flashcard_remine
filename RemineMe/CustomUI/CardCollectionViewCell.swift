//
//  CardCollectionViewCell.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/5/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbl_front: UILabel!
//    @IBOutlet weak var sub_view: UIView!
    override func layoutSubviews() {
          self.layer.cornerRadius = 25
          self.layer.borderColor = UIColor(red: 218/255, green: 223/255, blue: 225/255, alpha: 0.99).cgColor
//        dropShadow(sub_view: sub_view, color: UIColor.gray, opacity: 0.2, offSet: CGSize(width: 0, height: 2), radius: 7)
    }
    func dropShadow(sub_view: UIView, color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        sub_view.layer.masksToBounds = false
        sub_view.layer.shadowColor = color.cgColor
        sub_view.layer.shadowOpacity = opacity
        sub_view.layer.shadowOffset = offSet
        sub_view.layer.shadowRadius = radius
        
        sub_view.layer.shadowPath = UIBezierPath(rect: sub_view.bounds).cgPath
        sub_view.layer.shouldRasterize = true
        sub_view.layer.rasterizationScale = scale ? UIScreen.main.scale : 2
    }
}

