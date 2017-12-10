//
//  MyCardViewController.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/24/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Foundation
class MyCardViewController:  UIViewController,  UIScrollViewDelegate {
    var collection_id:Int64?
    
    @IBOutlet weak var tv_list: UITableView!
    @IBOutlet weak var cv_group: UICollectionView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var iv_cover: UIImageView!
    @IBOutlet weak var iv_profile: UIImageView!
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_desc: UILabel!
    
    var cards = [Card]()
    var collection: MyCollection?
    let db = CardDatabase.instance
    
    var selected_lesson: Int  = 1
    let lesson_in_row: Int = 3
    let card_per_lesson: Int = 10
    
    override func viewDidLoad() {
        // change selected bar color
        super.viewDidLoad()

        
        if (collection_id != nil){
            cards = db.getCards(_col_id: collection_id!)
            collection = db.getCollection(_col_id: collection_id!)
            init_collection(coll: collection!)
        }
        
        tableHeight.constant = self.view.frame.height-64
        self.tv_list.isScrollEnabled = false
        //no need to write following if checked in storyboard
        self.scrollView.bounces = false
        self.tv_list.bounces = true
        
        iv_cover.roundedCornerShadow()
        iv_profile.makeCircle()
        
        self.scrollView.contentOffset = CGPoint(x:0, y:0);
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            self.tv_list.isScrollEnabled = (self.scrollView.contentOffset.y >= 100)
        }
        
        if scrollView == self.tv_list {
            self.tv_list.isScrollEnabled = (tv_list.contentOffset.y > 0)
        }
    }

    func init_collection(coll: MyCollection){
        lbl_desc.text = coll.description
        lbl_title.text = coll.title
        iv_cover.image = UIImage.fromDatatypeValue(coll.cover!)
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        switch segmentController.selectedSegmentIndex
        {
            case 0:
                UIView.animate(withDuration: 0.5, animations: {
                    self.cv_group.alpha = 1
                    self.tv_list.alpha = 0
                })
            case 1:
                UIView.animate(withDuration: 0.5, animations: {
                    self.cv_group.alpha = 0
                    self.tv_list.alpha = 1
                })
            default:
                UIView.animate(withDuration: 0.5, animations: {
                    self.cv_group.alpha = 1
                    self.tv_list.alpha = 0
                })
        }

    }
    @IBAction func didTapClose(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension MyCardViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "card_test") as! FlipCardTableViewCell
        cell.front.text = cards[indexPath.row].original
        cell.back.text = cards[indexPath.row].translation
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
}

extension MyCardViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card_lesson", for: indexPath) as! CardGroupCollectionViewCell
        
        let shadowPath = UIBezierPath(rect: cell.bounds)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowPath = shadowPath.cgPath
        cell.layer.shadowRadius = 5
        cell.layer.cornerRadius = 10
        cell.lbl_lesson.text = "\(indexPath.section * 3 + indexPath.row + 1)"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(section)")
        if (section + 1) * lesson_in_row * card_per_lesson > cards.count{
            return cards.count % lesson_in_row
        }else{
            return lesson_in_row
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected_lesson = indexPath.section * lesson_in_row + indexPath.row
        self.performSegue(withIdentifier: "start_lesson", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // get a reference to the second view controller
        let secondViewController = segue.destination as! LessonViewController
        secondViewController.lesson = selected_lesson
        secondViewController.collection_id = collection_id
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cards.count / 30 + 1
    }
}

