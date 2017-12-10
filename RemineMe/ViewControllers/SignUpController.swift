//
//  LoginViewController.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 12/6/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit
import SwiftHTTP
class SignupViewController: UIViewController, RequestProtocol {
    var result:String?

    @IBOutlet weak var tv_name: UITextField!
    @IBOutlet weak var tv_email: UITextField!
    @IBOutlet weak var tv_password: UITextField!
    
    @IBOutlet weak var lbl_error: UILabel!
    let api = Request.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.dataDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func reset(){
        lbl_error.text = ""
    }
    
    func didReceiveResponse(result: Any?) {
        if let data = result {
            DispatchQueue.main.async{
                let json = try! JSONSerialization.jsonObject(with: data as! Data) as! Dictionary<String, Any>
                print(json)
                if json.keys.contains("error"){
                    self.lbl_error.isHidden = false
                    self.lbl_error.text = json["error"] as? String
                }else if json.keys.contains("success") {
                    self.lbl_error.isHidden = false
                    let defaults = UserDefaults.standard
                    defaults.set(true, forKey: Constants.USER_LOGGED)
                    defaults.set(json["user_id"], forKey: Constants.USER_ID)
                    self.performSegue(withIdentifier: "segue_load_main2", sender: self)

                }else{
                    self.lbl_error.isHidden = false
                    self.lbl_error.text = "Something is wrong, please try again"
                }
             
            }
        } else {
            self.lbl_error.isHidden = false
            self.lbl_error.text = "Something is wrong"
            
        }
    }

    @IBAction func didTabSignUp(_ sender: Any) {
        let name = tv_name.text
        let email = tv_email.text
        let password = tv_password.text
        let user:User = User(name:name!, email:email!, password:password!)
        api.send_post_request(params: user.to_dict(), url: String(format:"%@/%@", Constants.API_URL, "user"))

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _  = segue.destination as! MainViewController
//        secondViewController.collection_id = value_to_pass
    }
    
}

