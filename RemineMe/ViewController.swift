//
//  ViewController.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 10/31/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit
import SideMenu
import TesseractOCR

class ViewController: UIViewController,G8TesseractDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var favTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav_cell", for: indexPath) as! FavTableViewCell
        cell.pb_fav?.progress = Float(Double.random0to1())

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trend_cell", for: indexPath)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
         let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func recognize(){
        // section for OCR
        let tesseract:G8Tesseract = G8Tesseract(language:"eng+deu")
        tesseract.delegate = self
        //        tesseract.charWhitelist = "01234567890thequickfoxjumpedoverthelazydogTHEQUICKFOXJUMPEDOVERTHELAZYDOG"
        tesseract.image = UIImage(named: "test.png")
        tesseract.recognize()
        //        let inputString = tesseract.recognizedText
        
        print(tesseract.recognizedText)
        //
        //        let options = NSLinguisticTagger.Options.omitWhitespace.rawValue | NSLinguisticTagger.Options.joinNames.rawValue
        //        let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: Int(options))
        
        //        tagger.string = inputString
        //
        //        let range = NSRange(location: 0, length: (inputString?.utf16.count)!)
        //        tagger.enumerateTags(in: range, scheme: .nameTypeOrLexicalClass, options: NSLinguisticTagger.Options(rawValue: options)) { tag, tokenRange, sentenceRange, stop in
        //            guard let range = Range(tokenRange, in: inputString!) else { return }
        //            let token = inputString![range]
        //            print("\(String(describing: tag)): \(token)")
        //        }
        ////
    }
}

