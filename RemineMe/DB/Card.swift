//
//  Card.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/20/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import Foundation
class Card{
    let id: Int64?
    var original: String
    var translation: String
    var collection_id: Int64
    
    init(id: Int64) {
        self.id = id
        original = ""
        translation = ""
        collection_id = -1
    }
    
    init(_original: String) {
        self.id = -1
        original = _original
        translation = ""
        collection_id = -1
    }
    
    init(id: Int64, original: String, translation: String, collection_id: Int64) {
        self.id = id
        self.original = original
        self.translation = translation
        self.collection_id = collection_id
    }
}
