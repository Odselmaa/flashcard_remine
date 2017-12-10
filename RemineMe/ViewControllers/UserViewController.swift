//
//  UserViewController.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/20/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class UserViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var lbl_coll: UILabel!
    var itemInfo: IndicatorInfo = ""
    @IBOutlet weak var iv_profile: UIImageView!
    @IBOutlet weak var tv_coll: UITableView!
    
    var db = CardDatabase.instance
    var collections = [MyCollection]()
    
    var value_to_pass:Int64?
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        itemInfo.image = #imageLiteral(resourceName: "account_filled")
        return itemInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iv_profile.makeCircle()
        collections = db.getCollections()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collections = db.getCollections()
        tv_coll.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "my_card_cell") as! MyCollectionTableViewCell
        cell.lbl_title.text = collections[indexPath.row].title
        cell.lbl_desc.text = collections[indexPath.row].description
        cell.lbl_count.text = "\(collections[indexPath.row].count_card)"
        if let cover_blob = collections[indexPath.row].cover {
            cell.iv_cover.image = UIImage.fromDatatypeValue(cover_blob)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        value_to_pass = collections[indexPath.row].id!
        self.performSegue(withIdentifier: "my_cards", sender: self)
        //now call your delegate method here
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // get a reference to the second view controller
        let secondViewController = segue.destination as! MyCardViewController

        // set a variable in the second view controller with the data to pass
        secondViewController.collection_id = value_to_pass
    }
    
    
}

extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: frame.size.width - 10, height: width)
        self.layer.addSublayer(border)
    }
}
