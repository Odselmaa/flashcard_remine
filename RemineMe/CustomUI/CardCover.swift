//
//  CardCover.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/26/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit

class CardCover: UIImageView {

    /*
     Only override draw() if you perform custom drawing.
     An empty implementation adversely affects performance during animation.

    */
    override func draw(_ rect: CGRect) {
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowPath = shadowPath.cgPath
    }
    
}
