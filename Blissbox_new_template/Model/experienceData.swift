//
//  experienceData.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 9/1/18.
//  Copyright © 2018 ANG RUI XIAN . All rights reserved.
//

import Foundation

class experienceData{
    var id : Int?
    var company_id : Int?
    var thumbnail : String?
    var name : String?
    var code : String?
    var pax : Int?
    var duration : String?
    var email : String?
    var phone : String?
    var address : String?
    var requirements : String?
    var services : String?
    var information : String?
    var deleted_at : String?
    var created_at : String?
    var updated_at : String?
    
    var experienceArray : [experienceData] = []
    
    // the singleton object
    static let sharedInstance = experienceData()
    
    init(){
    }
    init(id:Int,company_id:Int,thumbnail:String,name:String,code:String,pax:Int,duration:String,email:String,phone:String,address:String,requirements:String,services:String,information:String,deleted_at:String,created_at:String,updated_at:String) {
        self.id = id
        self.company_id = company_id
        self.thumbnail = thumbnail
        self.name = name
        self.code = code
        self.pax = pax
        self.duration = duration
        self.email = email
        self.phone = phone
        self.address = address
        self.requirements = requirements
        self.services = services
        self.information = information
        self.deleted_at = deleted_at
        self.created_at = created_at
        self.updated_at = updated_at
        
    }
    
    init(name:String,thumbnail:String) {
        self.name = name
        self.thumbnail = thumbnail
    }
    func get(index:Int) -> experienceData {
        return experienceArray[index]
    }
    
}
