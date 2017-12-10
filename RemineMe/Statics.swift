//
//  Statics.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 12/6/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import Foundation

func str2json(){
    
}
func json2str(_ dict: Dictionary<String, Any>)->String{
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
        return String(describing:decoded)
    } catch {
        print(error.localizedDescription)
        return "error"
    }

}
