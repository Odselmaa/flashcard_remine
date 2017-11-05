//
//  AddCardViewController.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/3/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "add_card")
        return cell!
    }
    
    
//    @IBOutlet weak var iv_cover: CardCover!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
