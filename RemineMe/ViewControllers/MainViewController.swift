//
//  MainViewController.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/20/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit
import Foundation
import XLPagerTabStrip


class MainViewController: BaseButtonBarPagerTabStripViewController<YoutubeIconCell> {
    let unselectedIconColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1.0)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        buttonBarItemSpec = ButtonBarItemSpec.nibFile(nibName: "YoutubeIconCell", bundle: Bundle(for: YoutubeIconCell.self), width: { _ in
            return 40
        })
    }

    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = UIColor.darkGray
        settings.style.selectedBarBackgroundColor = unselectedIconColor
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: YoutubeIconCell?, newCell: YoutubeIconCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.iconImage.tintColor = self?.unselectedIconColor
            newCell?.iconImage.tintColor = UIColor.darkGray
        }
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let child_1 = storyboard.instantiateViewController(withIdentifier: "child1")
        let child_2 = storyboard.instantiateViewController(withIdentifier: "child2")
        let child_3 = storyboard.instantiateViewController(withIdentifier: "child3")
        
        let child_4 = storyboard.instantiateViewController(withIdentifier: "child4")
        return [child_1,child_2, child_3, child_4]
    }
    override func configure(cell: YoutubeIconCell, for indicatorInfo: IndicatorInfo) {
        cell.iconImage.image = indicatorInfo.image?.withRenderingMode(.alwaysTemplate)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
