//
//  User.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 12/6/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import Foundation

class User{
    var id: String
    var name: String
    var password: String
    var email: String
    
    init(name: String,  email:String,password: String){
        self.id = ""
        self.name = name
        self.password = password
        self.email = email
    }

    init(id:String, name: String, email:String,password: String){
        self.id = id
        self.name = name
        self.password = password
        self.email = email
    }

//    init(json:Dictionary<String, Any>){
//        self.id = json["id"]
//        self.email = json["email"]
//        self.password = json["password"]
//        self.name = json["name"]
//    }
    
    func to_dict()->Dictionary<String, Any>{
        let dict:Dictionary<String, Any> = [ "name":self.name, "password":self.password, "email":self.email]
        return dict
    }
}


