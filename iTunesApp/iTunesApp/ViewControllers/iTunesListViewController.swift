//
//  iTunesListViewController.swift
//  iTunesApp
//
//  Created by Austin West on 5/16/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import UIKit

class iTunesListViewController: UIViewController {

    var results: [iTunesResults] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension iTunesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTuneCell", for: indexPath) as?
        iTunesItemTableViewCell
        
        let result = results[indexPath.row]
        
        cell?.iTunesResult = result
        
        iTunesResultsController.fetchImageFor(iTunesResult: result) { (image) in
            DispatchQueue.main.async {
                cell?.artworkImageView.image = image
            }
        }
        
        return cell ?? UITableViewCell()
    }
    
    
}

extension iTunesListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        iTunesResultsController.searchItunesFor(searchTerm: searchTerm) { (results) in
            self.results = results
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
