//
//  CardGroupViewController.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/25/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CardGroupViewController: UIViewController {
    var itemInfo: IndicatorInfo = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension CardGroupViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        itemInfo.image  = #imageLiteral(resourceName: "home_filled")
        return itemInfo
    }
}
