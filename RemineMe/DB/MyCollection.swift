//
//  MyCollection.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/21/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class MyCollection{
    let id: Int64?
    var title: String
    var description: String
    var progress: Double
    var count_card: Int = 0
    var cover: Blob?
    
    init(title: String, description: String, cover: Blob){
        self.id = 1
        self.title = title
        self.description = description
        self.progress = 0
        self.cover = cover
    }
    init(id: Int64, title: String, description: String, cover: Blob){
        self.id = id
        self.title = title
        self.description = description
        self.progress = 0
        self.cover = cover
    }
    init(id:Int64, title: String, description: String, cover:Blob,  progress: Double, count: Int){
        self.id = id
        self.title = title
        self.description = description
        self.progress = progress
        self.count_card = count
        self.cover = cover
    }
}
