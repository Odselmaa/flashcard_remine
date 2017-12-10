//
//  Database.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 11/19/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import SQLite
class CardDatabase{
    static let instance = CardDatabase()
    private let db: Connection?
    
    private let cards = Table("cards")
    private let card_id = Expression<Int64>("id")
    private let card_original = Expression<String?>("original")
    private let card_translations = Expression<String>("translations")
    private let card_col_id = Expression<Int64>("col_id")

    
    private let collections = Table("collections")
    private let col_id = Expression<Int64>("id")
    private let col_title = Expression<String>("title")
    private let col_desc = Expression<String>("description")
    private let col_progress = Expression<Double>("progress")
    private let col_cover = Expression<Blob>("cover")

    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/CardDB3.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createCard()
        createCollection()
    }
    func createCard() {
        do {
            try db!.run(cards.create(ifNotExists: true) { table in
                table.column(card_id, primaryKey: .autoincrement)
                table.column(card_original)
                table.column(card_translations)
                table.column(card_col_id)
                table.foreignKey(card_col_id, references: collections, col_id)
            })
        } catch {
            print("Unable to create table")
        }
    }
    func createCollection() {
        do {
            try db!.run(collections.create(ifNotExists: true) { table in
                table.column(col_id, primaryKey: .autoincrement)
                table.column(col_title)
                table.column(col_progress)
                table.column(col_desc)
                table.column(col_cover)

            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func addCard(card: Card) -> Int64? {
        do {
            let insert = cards.insert(card_original <- card.original, card_translations <- card.translation, card_col_id <- card.collection_id)
            let id = try db!.run(insert)
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    func addCards(_cards: [Card], _col_id: Int64) ->Int64 {
        var last_id:Int64 = 0
        do {
            for card in _cards {
                let insert = cards.insert(card_original <- card.original, card_translations <- card.translation, card_col_id <- _col_id)
                last_id = try db!.run(insert)
            }
            return last_id
        } catch {
            print("Insert failed")
            return last_id
        }
    }
    
    
    func addCollection(coll: MyCollection) -> Int64? {
        do {
            let insert = collections.insert(col_title <- coll.title, col_desc <- coll.description, col_cover <- coll.cover!, col_progress <- coll.progress)
            let id = try db!.run(insert)
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    func getCards(_col_id:Int64, limit:Int? = nil, skip:Int=0) -> [Card] {
        var cards = [Card]()
        var filtered:QueryType
        do {
            if (limit == nil){
                filtered = self.cards.filter(card_col_id == _col_id)
            }else{
                filtered = self.cards.filter(card_col_id == _col_id).limit(limit!, offset: skip)
            }
            for card in try db!.prepare(filtered) {
                cards.append(Card(
                    id: card[card_id],
                    original: card[card_original]!,
                    translation: card[card_translations],
                    collection_id: card[card_col_id]))
            }
        } catch {
            print("Select failed")
            return []
        }
        return cards
    }
    func getCollections() -> [MyCollection] {
        var collections = [MyCollection]()
        do {
            for coll in try db!.prepare(self.collections) {
                
                let count:Int = try db!.scalar(cards.filter(card_col_id == coll[col_id]).count)
                collections.append(MyCollection(
                id: coll[col_id],
                title: coll[col_title],
                description: coll[col_desc],
                cover:coll[col_cover],
                progress: coll[col_progress],
                count: count))
            }
        } catch {
            print("Select failed")
            return []
        }
        return collections
    }
    
    func getCollection(_col_id: Int64) -> MyCollection{
        let query = collections.filter(col_id == _col_id).limit(1)
        var coll: MyCollection?
        do{
            for item in try db!.prepare(query){
                coll =  MyCollection(
                    id: item[col_id],
                    title: item[col_title],
                    description: item[col_desc],
                    cover: item[col_cover]
                )
                break
            }
        }catch{
            print("Select failed")
        }
        return coll!

    }
    
    func deleteAll(){
        do {
            try db?.run(cards.delete())
            try db?.run(collections.delete())
        } catch {
            print("Delete failed")
            return
        }
    }
}
