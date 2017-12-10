//
//  AddCardViewController.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/3/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit
import TesseractOCR
import SwiftHTTP
import XLPagerTabStrip

class AddCardViewController: UIViewController, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, G8TesseractDelegate {

    @IBOutlet weak var iv_cover: CardCover!
    @IBOutlet weak var tf_cover: UILabel!
    @IBOutlet weak var tv_card: UITableView!
    @IBOutlet weak var tf_title: UITextField!
    @IBOutlet weak var tf_description: UITextField!
    
    
    let tesseract:G8Tesseract = G8Tesseract(language:"eng+rus")
    
    var is_cover_clicked: Bool = false
    var is_add_card_clicked: Bool = false
    
    var picker:UIImagePickerController? = UIImagePickerController()
    
    var cards = [Card]()
    var itemInfo: IndicatorInfo = ""
    var value_to_pass:Int64?

    let db = CardDatabase.instance
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tv_card.separatorColor = UIColor(red: 218/255, green: 223/255, blue: 225/255, alpha: 0.99)
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        
        picker?.delegate = self
        tesseract.delegate = self
    }
    
    @IBAction func didTapPublish(_ sender: UIButton) {
        let title = tf_title.text!
        let description = tf_description.text!
        let col_id = db.addCollection(coll: MyCollection(title:title, description:description, cover: (iv_cover.image?.datatypeValue)!))
//        print("Collection id: \(col_id!)")
        _ = db.addCards(_cards: cards, _col_id: col_id!)
        value_to_pass = col_id
        self.performSegue(withIdentifier: "segue_added_card", sender: self)
    }
    
    @IBAction func add_cards(_ sender: Any) {
        is_add_card_clicked = true
        openGallery()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "add_card") as! AddCardTableViewCell
//        cell.front_text = items![indexPath.row] as! String
        cell.lbl_card.text = cards[indexPath.row].original
        cell.lbl_rear.text = cards[indexPath.row].translation
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewController = segue.destination as! MyCardViewController
        secondViewController.collection_id = value_to_pass
        make_free()
    }
    
    func make_free(){
        cards.removeAll()
        tv_card.reloadData()
        tf_title.text = ""
        tf_description.text = ""
        iv_cover.image = nil
    }
    
    @IBAction func choose_cover(recognizer:UITapGestureRecognizer) {
        is_cover_clicked = true
        openGallery()
        
    }
    
    func openGallery()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        if is_cover_clicked {
            is_cover_clicked = false
            let newImage = chosenImage.resizeImage(targetSize: CGSize(width: iv_cover.frame.width * 2, height: iv_cover.frame.height * 2))
            iv_cover.image = newImage
//            iv_cover.contentMode = .scaleAspectFill
            tf_cover.isHidden = true
            print("Add card from outside button is clicked")
        }
        
        if is_add_card_clicked{
            is_add_card_clicked = false
            print("Add card from outside button is clicked")
            let recognizedText = self.performImageRecognition(image: chosenImage)
            // Bounce back to the main thread to update the UI
            
            self.text2card(recognizedText.lowercased())
//            print(recognizedText)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func performImageRecognition(image: UIImage)->String{
        tesseract.image = image
        tesseract.recognize()
        return tesseract.recognizedText
    }
    
    func text2card(_ text: String){
        var lang2lang:String?
        if let lang = NSLinguisticTagger.dominantLanguage(for: text) {
            if lang == "en" {
                lang2lang = "en-ru"
            }else{
                lang2lang = "ru-en"
            }
            print(lang2lang!)
        }
        
        var textIterator = Set(text.words).makeIterator()
        var indexPaths = [IndexPath]()
        var i : Int = 0
        while let word  = textIterator.next() {
            
            if !word.containsCharacter(CharacterSet.decimalDigits) && !word.containsCharacter(CharacterSet.symbols) {
                cards.append(Card(_original:word))
                indexPaths.append(IndexPath(row: i, section: 0))
                i = i + 1
                
            }
        }
        
        tv_card.beginUpdates()
        tv_card.insertRows(at: indexPaths, with: .left)
        tv_card.endUpdates()
        
        if (lang2lang != nil){
            DispatchQueue.global(qos: .default).async {
                i = 0
                for card in self.cards{
                    _ = self.send_request(card.original, i, lang:lang2lang!)
                    i = i + 1
                }
                DispatchQueue.main.async (execute: {
                    self.tv_card.reloadData()
                    
                    
                    
                })
            }
        }
    }
    
    
    func send_request(_ text:String, _ index: Int, lang: String) -> String{
        var translation:String = ""
        let escaped_text = text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url:String = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20170405T153325Z.ecbd956505b5de0c.3a70ba5f8531cb506c75cfb400181b4f401efef3&text=\(escaped_text!)&lang=\(lang)"
        HTTP.GET(url) {
            response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                print(response.data)
                return //also notify app of failure as needed
            }

            let json = response.text?.convertToDictionary()
            if let names = json!["text"] as? [String] {
                translation = names.joined(separator: ",")
            }
            self.cards[index].translation = translation
        }
        return translation
    }
    
    func refresh_u(){

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


extension String {
    
    func scalar(scalar: UnicodeScalar, isInRanges ranges: [Range<Int>]) -> Bool {
        for r in ranges {
            if r ~= Int(scalar.value) {
                return true
            }
        }
        return false
    }

 
    var words: [String] {
        return components(separatedBy: .punctuationCharacters)
            .joined()
            .components(separatedBy: CharacterSet.whitespacesAndNewlines)
            .filter{!$0.isEmpty}
    }
    func containsCharacter(_ characters: CharacterSet) -> Bool {
        // check if there's a range for a number
        let range = self.rangeOfCharacter(from: characters)
        // range will be nil if no whitespace is found
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func guessLanguage() -> String {
        let length = self.utf16.count
        let languageCode = CFStringTokenizerCopyBestStringLanguage(self as CFString, CFRange(location: 0, length: length)) as String? ?? ""
        let locale = Locale(identifier: languageCode)
        return locale.localizedString(forLanguageCode: languageCode) ?? "Unknown"
    }
    
}

extension AddCardViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        itemInfo.image = #imageLiteral(resourceName: "plus")
        return itemInfo

    }
}


