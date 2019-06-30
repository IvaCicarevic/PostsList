//
//  Networking.swift
//  PostsList
//
//  Created by Iva Cicarevic on 5/29/19.
//  Copyright © 2019 Iva Cicarevic. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper



struct Networking {
    
    
    // MARK: - url
    private static let baseUrl = "https://jsonplaceholder.typicode.com"
    
    private static let postsUrl = "\(Networking.baseUrl)/posts"
    
    private static func getPostUrl(withId id: Int) -> String {
        return "\(Networking.baseUrl)/posts"
    }
    
    private static func getDetailsUrl(withId id: Int) -> String {
        return "\(Networking.baseUrl)/posts/\(id)/comments"
    }
    
    
    // MARK: - Posts Networking
    func requestFetchPosts(completion: @escaping (Posts?, Error?) -> ()) {
        Alamofire.request(Networking.postsUrl).responseJSON { response in
            print("Networking: requestFetchPosts: Request: \(String(describing: response.request))")
            print("Networking: requestFetchPosts: Response: \(String(describing: response.response))")
            print("Networking: requestFetchPosts: Result: \(response.result)")
            
            if let error = response.error {
                print("Networking: fetchPosts: error: \(error.localizedDescription)")
                completion(nil, error)
            }
            
            if let json = response.result.value {
                let posts = Mapper<UserPost>().mapArray(JSONObject: json)
                completion(posts, nil)
            }
        }
    }
    
    
    // MARK: - Details Newtworking
    func requestFetchDetails(withPostId postId: Int, completion: @escaping (Details?, Error?) -> ()) {
        Alamofire.request(Networking.getDetailsUrl(withId: postId)).responseJSON { response in
            if let error = response.error {
                print("Networking: requestFetchDetails: error: \(error.localizedDescription)")
                completion(nil, error)
            }
            if let json = response.result.value {
                let details = Mapper<Detail>().mapArray(JSONObject: json)
                completion(details, nil)
            }
        }
    }
}

