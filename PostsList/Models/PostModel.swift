//
//  User.swift
//  PostsList
//
//  Created by Iva Cicarevic on 5/29/19.
//  Copyright © 2019 Iva Cicarevic. All rights reserved.
//

import Foundation
import ObjectMapper


typealias Posts = [UserPost]

struct UserPost: Mappable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.userId     <- map["userId"]
        self.id         <- map["id"]
        self.title      <- map["title"]
        self.body         <- map["body"]
    }
    
    
}
