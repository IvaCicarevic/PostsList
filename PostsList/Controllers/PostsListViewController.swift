//
//  ViewController.swift
//  PostsList
//
//  Created by Iva Cicarevic on 5/29/19.
//  Copyright © 2019 Iva Cicarevic. All rights reserved.
//

import UIKit

class PostsListViewController: UIViewController {

    //MARK: -outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: -vars
    internal var postViewModel: UserPostViewModel!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - View life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tryFetchPosts()
        
        
        print("An app screen has appeared")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        postViewModel = UserPostViewModel(service: Networking())
        setupTableView()
        setupSearchController()
        
        
    }

    
    // MARK: - setup UI Table View
    private func setupTableView() {
        
        tableView.dataSource = self as? UITableViewDataSource
        tableView.delegate = self as? UITableViewDelegate
        tableView.tableFooterView = UIView()
    
    }
  
    // MARK: - setup UI search controller
    func setupSearchController() {
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController

    }

    
    //MARK: -updateUI
    private func updateUI(withStatus success: Bool, error: Error?) {
        DispatchQueue.main.async {
            if success {
                self.tableView.reloadData()
            } else {
                print("Did not update UI")
            }
        }
    }
    
    // MARK: - Network Call
    
    private func tryFetchPosts() {
        postViewModel.requestPosts {[weak self] (success, error) in
            if error != nil {
                self?.updateUI(withStatus: false, error: error)
                return
            }
            self?.updateUI(withStatus: success, error: nil)
        }
        if postViewModel.posts.count == 1 {
            print("Post downloading get started")
    }

    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            let detailsVC = segue.destination as! DetailsViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let post = postViewModel.posts[indexPath.row]
            detailsVC.postId = post.id
        }
    }
}

// MARK: - UITableViewDataSource
extension PostsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postViewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellPosts", for: indexPath) as! PostDataCell
        
        let datas = postViewModel.posts[indexPath.row]
        
       cell.datas = datas
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: nil)
        
        print("User has tapped a list item")
    }

}
    
    

