//
//  CardCover.swift
//  Remine
//
//  Created by Odselmaa Dorjsuren on 10/28/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit

@IBDesignable
class CardCover: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor(red: 218/255, green: 223/255, blue: 225/255, alpha: 0.4).cgColor
//        self.layer.borderColor = UIColor.gray.cgColor

        self.layer.borderWidth = 0.2
        dropShadow(color: UIColor.gray, opacity: 0.2, offSet: CGSize(width: 0, height: 3), radius: 4)

    }
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 2
    }
}
