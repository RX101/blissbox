//
//  giftboxData.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 9/1/18.
//  Copyright © 2018 ANG RUI XIAN . All rights reserved.
//

import Foundation

class giftboxData{
    var id : Int?
    var universe_id : Int?
    var initial : String?
    var thumbnail : String?
    var name : String?
    var price : Float?
    var description : String?
    var pdf_url : String?
    var review : Int?
    var deleted_at : String?
    var created_at : String?
    var updated_at : String?
    
    var giftboxArray : [giftboxData] = []
    // the singleton object
    static let sharedInstance = giftboxData()
    
    init() {
    }
    
    init(id:Int,universe_id:Int,initial:String,thumbnail:String,name:String,price:Float,description:String,pdf_url:String,review:Int,deleted_at:String,created_at:String,updated_at:String) {
        self.id = id
        self.universe_id = universe_id
        self.initial = initial
        self.thumbnail = thumbnail
        self.name = name
        self.price = price
        self.description = description
        self.pdf_url = pdf_url
        self.review = review
        self.deleted_at = deleted_at
        self.created_at = created_at
        self.updated_at = updated_at
    }
    
    init(name:String,thumbnail: String) {
        self.name = name
        self.thumbnail = thumbnail
    }
    
    init(name:String,price: Float, thumbnail: String, description: String) {
        self.name = name
        self.price = price
        self.thumbnail = thumbnail
        self.description = description
    }
    
    init(name:String,price: Float, thumbnail: String, description: String,universe_Id: Int) {
        self.name = name
        self.price = price
        self.thumbnail = thumbnail
        self.description = description
        self.universe_id = universe_Id
    }
    
    
    func get(index:Int) -> giftboxData {
        return giftboxArray[index]
    }

}
