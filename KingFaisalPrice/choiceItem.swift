//
//  choiceItem.swift
//  KingFaisalPrice
//
//  Created by Apple on 12/14/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

struct choiceItem:Decodable{
    
    var name:String?
    var link:String?
    var video:String?
    var certif:String?
    var file:String?
    
    init(name:String,link:String,video:String,certif:String,file:String) {
        
        self.name = name
        self.link = link
        self.video = video
        self.certif = certif
        self.file = file
    }
    
}
