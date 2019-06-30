//
//  UserPostViewModel.swift
//  PostsList
//
//  Created by Iva Cicarevic on 5/29/19.
//  Copyright © 2019 Iva Cicarevic. All rights reserved.
//

import Foundation


class UserPostViewModel {
    
    
    // MARK: - vars
    var posts: [UserPost] = []
    var error: Error?
    var refreshing = false
    
    private var service: Networking?
    
    init(service: Networking) {
        self.service = service
    }
    
    
    // MARK: - Networking
    func requestPosts(completion: @escaping (Bool, Error?) -> ()) {
        
        
        service?.requestFetchPosts(completion: { (posts, error) in
            if let errors = error {
                self.error = errors
                self.refreshing = false
                self.posts = []
                completion(false, error)
            } else {
                self.error = nil
                self.refreshing = false
                if let items = posts {
                    self.posts = items
                    completion(true, nil)
                }
            }
        })
    }
}
