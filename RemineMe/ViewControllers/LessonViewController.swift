//
//  LessonViewController.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/27/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {

    @IBOutlet weak var pv_lesson: UIProgressView!
    @IBOutlet weak var cv_cards: UICollectionView!
    @IBOutlet weak var btn_answer_1: UIButton!
    @IBOutlet weak var btn_answer_2: UIButton!
    @IBOutlet weak var btn_answer_3: UIButton!
    var buttons = [UIButton]()
    var answer_sequence = [Int]()
    var card_sequence = [Int]()
    var card_per_lesson:Int = 10
    var current_position:Int = 0
    var lesson: Int = 1
    
    var collection_id: Int64?
    var cards = [Card]()
    let db = CardDatabase.instance
    var right_answer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        init_data()
//        init_pv()
//        init_buttons(card_sequence[0])
        
    }
    
    func init_data(){
        
        cards = db.getCards(_col_id: collection_id!, limit: card_per_lesson, skip: lesson * card_per_lesson)
        card_per_lesson = cards.count
        card_sequence = Array(0..<card_per_lesson).shuffled()
        buttons = [btn_answer_1, btn_answer_2, btn_answer_3]
        
    }
    
    func init_pv(){
        pv_lesson.transform = pv_lesson.transform.scaledBy(x:1, y:1.4);

        pv_lesson.layer.cornerRadius = 3
        pv_lesson.layer.masksToBounds = true
        pv_lesson.clipsToBounds = true
    }
    func init_buttons(_ card_index:Int){
        answer_sequence = Array(0...2).shuffled()
        var answers = [String]()
        answers.append(cards[card_index].translation)
        var a:Int = 0
        var b:Int = 0
        while (a == b || card_index == b || card_index == a){
            a = Int.init(random: 0..<card_per_lesson)
            b = Int.init(random: 0..<card_per_lesson)
        }
        answers.append(cards[a].translation)
        answers.append(cards[b].translation)
        for (index,button) in buttons.enumerated() {
            button.setTitle(answers[answer_sequence[index]], for: .normal)
        }
//        print(answer_sequence)
//        print(a)
//        print(b)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(answer_sequence)
        init_data()
        
        for button in buttons{
            button.roundCorner()
        }
        
        init_pv()
        init_buttons(card_sequence[0])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didTapAnswer1(_ sender: UIButton) {
        if check_answer(0){
            willContinue()
            
        }
    }
    
    @IBAction func didTapAnswer2(_ sender: UIButton) {
        if check_answer(1){
            willContinue()
        }
    }
    
    @IBAction func didTapAnswer3(_ sender: UIButton) {
        if check_answer(2){
            willContinue()
        }
    }
    
    func check_answer(_ index: Int) -> Bool{
        return answer_sequence[index] == 0
    }
    
    func willContinue() {

        if current_position < cards.count - 1{
            current_position += 1
            pv_lesson.progress = Float(current_position + 1) / Float(cards.count)
            self.cv_cards.scrollToItem(at:IndexPath(item: current_position, section: 0), at: .right, animated: true)
            init_buttons(card_sequence[current_position])
            pv_lesson.progress = Float(current_position) / Float(cards.count)
        }else{
            pv_lesson.progress = 1.0
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
extension LessonViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card_lesson", for: indexPath) as! FlipCardCollectionViewCell
        cell.isTapable = false
        let index = card_sequence[indexPath.row]
//        cell.front.text = cards[index].original
        cell.back.text = cards[index].original
//        print(indexPath)
        return cell
    }
}
