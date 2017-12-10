//
//  SignupViewController.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 12/6/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, RequestProtocol{

    @IBOutlet weak var tv_username: UITextField!
    @IBOutlet weak var tv_password: UITextField!
    
    @IBOutlet weak var lbl_error: UILabel!
    let api = Request.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        api.dataDelegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        let username = tv_username.text
        let password = tv_password.text
        let params:Dictionary<String, Any> = ["email":username!, "password":password!]
        api.send_get_request(params: params, url: String(format:"%@/%@", Constants.API_URL, "user"))
    }
    
    func didReceiveResponse(result: Any?) {
        if let data = result {
            DispatchQueue.main.async{
                let json = try! JSONSerialization.jsonObject(with: data as! Data) as! Dictionary<String, Any>
                print(json)
                if json.keys.contains("error"){
                    self.lbl_error.alpha = 1
                    self.lbl_error.text = json["error"] as? String
                    
                }else if json.keys.contains("success") {
                    self.lbl_error.alpha = 1
                    self.lbl_error.text = json["success"] as? String
                    let defaults = UserDefaults.standard
                    defaults.set(true, forKey: Constants.USER_LOGGED)
                    defaults.set(json["user_id"], forKey: Constants.USER_ID)
                    self.performSegue(withIdentifier: "segue_load_main1", sender: self)
                }else{
                    self.lbl_error.alpha = 1
                    self.lbl_error.text = "Something is wrong, please try again"
                }
                
            }
        } else {
            self.lbl_error.isHidden = false
            self.lbl_error.text = "Something is wrong"
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _  = segue.destination as! MainViewController
        //        secondViewController.collection_id = value_to_pass
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
