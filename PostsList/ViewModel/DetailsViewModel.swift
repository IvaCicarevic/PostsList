//
//  DetailsViewModel.swift
//  PostsList
//
//  Created by Iva Cicarevic on 5/30/19.
//  Copyright © 2019 Iva Cicarevic. All rights reserved.
//

import Foundation

class DetailsViewModel {
    
    
    // MARK: - vars
    var details: [Detail] = []
    var error: Error?
    var refreshing = false
    
    private var service: Networking?
    
    
    // MARK: - Object Life Cycle
    init(service: Networking) {
        self.service = service
    }
    
    
    // MARK: - Networking
    func requestDetails(withPostId postId: Int, completion: @escaping (Bool, Error?) -> ()) {
        service?.requestFetchDetails(withPostId: postId, completion: { (details, error) in
            if let errors = error {
                self.error = errors
                self.refreshing = false
                self.details = []
                completion(false, error)
            } else {
                self.error = nil
                self.refreshing = false
                if let items = details {
                self.details = items
                completion(true, nil)
                }
            }
        })
    }
}

