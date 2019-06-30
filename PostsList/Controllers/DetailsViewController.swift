//
//  DetailsViewController.swift
//  PostsList
//
//  Created by Iva Cicarevic on 5/30/19.
//  Copyright © 2019 Iva Cicarevic. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - vars
    internal var detailViewModel: DetailsViewModel!
    
    var postId: Int? {
        didSet {
            print("postId: \(String(describing: postId))")
        }
    }
    
    
    // MARK: - view life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let postId = postId else { return }
        tryFetchDetails(withPostId: postId)
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailViewModel = DetailsViewModel(service: Networking())
        setupTableView()

    }
    
    // MARK: - setup UI Table View
    private func setupTableView() {
        
        tableView.dataSource = self as? UITableViewDataSource
        tableView.delegate = self as? UITableViewDelegate
        tableView.tableFooterView = UIView()
       
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
    private func tryFetchDetails(withPostId postId: Int) {
        detailViewModel?.requestDetails(withPostId: postId) {[weak self] (success, error) in
            if error != nil {
                self?.updateUI(withStatus: success, error: nil)
                return
            }
            self?.updateUI(withStatus: success, error: error)
        }
    }
}

// MARK: - UITableViewDataSource
extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailViewModel.details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellDetails", for: indexPath) as! DetailsDataCell
        let detail = detailViewModel.details[indexPath.row]
        cell.datas = detail
        
        return cell
    }
}
