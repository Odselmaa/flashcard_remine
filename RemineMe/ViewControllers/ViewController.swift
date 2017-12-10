//
//  ViewController.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 10/31/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit
import TesseractOCR
import XLPagerTabStrip

class ViewController: UIViewController,G8TesseractDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var favTableView: UITableView!
    
    var itemInfo: IndicatorInfo = ""
    var collections = [MyCollection]()
    let db = CardDatabase.instance
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav_cell", for: indexPath) as! FavoTableViewCell
        cell.pb_fav?.progress = 0.6
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trend_cell", for: indexPath) as! CardTrendCollectionViewCell
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        itemInfo.image  = #imageLiteral(resourceName: "home_filled")
        return itemInfo
    }
    
    
}

