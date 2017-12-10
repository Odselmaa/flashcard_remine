//
//  FlipCardTableViewCell.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/26/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit
import AVFoundation

class FlipCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    var front: UILabel!
    var back: UILabel!
    var showingBack = true
    
    override func awakeFromNib() {

        let x = cardView.bounds.width * 0.1
        let y = cardView.bounds.height  * 0.1

        let rect = CGRect(x: x, y: y, width: cardView.frame.width * 0.8, height: cardView.frame.height * 0.8)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        singleTap.numberOfTapsRequired = 1
        
        front = UILabel(frame:rect)
        front.text = "Front"
        front.textAlignment = .center
        
        back = UILabel(frame:rect)
        back.text = "Back"
        back.textAlignment = .center
        
        cardView.addGestureRecognizer(singleTap)
        cardView.isUserInteractionEnabled = true
        cardView.addSubview(back)
    }
  

    override func draw(_ rect: CGRect) {
        let shadowPath = UIBezierPath(rect: cardView.bounds)
        cardView.layer.backgroundColor = UIColor.white.cgColor
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        cardView.layer.shadowOpacity = 0.3
        cardView.layer.shadowRadius = 10
        cardView.layer.cornerRadius = 30
        cardView.layer.masksToBounds = false
        cardView.layer.shadowPath = shadowPath.cgPath
    }
    
    @objc func tapped() {
        var showingSide = front
        var hiddenSide = back
        if showingBack {
            (showingSide, hiddenSide) = (back, front)
        }
        
        UIView.transition(from: showingSide!,
                          to: hiddenSide!,
                                  duration: 0.2,
                                  options: UIViewAnimationOptions.transitionFlipFromRight,
                                  completion: nil)
        
        showingBack = !showingBack
    }
    

    @IBAction func didTapTalk(_ sender: UIButton) {
        var string = ""
        if showingBack{
            
            string = back.text!
        }else{
            string = front.text!
        }
        let utterance = AVSpeechUtterance(string: string)
        
        if showingBack{
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        }else{
            utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")

        }
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
