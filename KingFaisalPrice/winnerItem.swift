//
//  winnerItem.swift
//  KingFaisalPrice
//
//  Created by Apple on 12/14/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

struct winnerItem:Decodable{
    
    var name:String?
    var link:String?
    var type:String?
    var image:String?
    
    init(name:String,link:String,type:String,image:String) {
        
        self.name = name
        self.link = link
        self.type = type
        self.image = image
    }
    
}
