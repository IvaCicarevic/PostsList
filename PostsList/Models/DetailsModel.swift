//
//  DetailsModel.swift
//  PostsList
//
//  Created by Iva Cicarevic on 5/30/19.
//  Copyright © 2019 Iva Cicarevic. All rights reserved.
//

import Foundation
import ObjectMapper

typealias Details = [Detail]

struct Detail: Mappable {
    var postId: Int?
    var id: Int?
    var name: String?
    var email: String?
    var body: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.postId     <- map["postId"]
        self.id         <- map["id"]
        self.name       <- map["name"]
        self.email      <- map["email"]
        self.body       <- map["body"]
    }
    
}
