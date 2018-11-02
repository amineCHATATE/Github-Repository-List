//
//  RepoTableViewController.swift
//  Github-Repository-Swift
//
//  Created by Amine CHATATE on 11/2/18.
//  Copyright © 2018 Amine CHATATE. All rights reserved.
//

import UIKit
import SDWebImage

class RepoTableViewController: UITableViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var connect = GetData()
    var arrayRepository = Array<Repository>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Trending"
        self.connect.delegate = self
        self.startActivityIndicator()
        self.connect.getFirstRepositoryPage()
        self.tableView.rowHeight = 150
    }
    
    func reachListEnd(count: Int, currentIndex: Int, currentRepository: Repository ) -> Bool {
        let lastRepository = self.arrayRepository[count - 1]
        if lastRepository.name.elementsEqual(currentRepository.name) {
            return true
        }
        return false
    }
    
    func startActivityIndicator() {
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
    }
}

extension RepoTableViewController{
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayRepository.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "row", for: indexPath) as! RepoTableViewCell
        
        cell.name.text = self.arrayRepository[indexPath.row].name
        cell.username.text = self.arrayRepository[indexPath.row].owner.login
        cell.desc.text = self.arrayRepository[indexPath.row].description
        cell.NoS.text = String(self.arrayRepository[indexPath.row].stargazers_count)
        
        cell.avatar.sd_setImage(with: self.arrayRepository[indexPath.row].owner.avatar_url, completed: nil)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.cellAnimate()
        
        if self.reachListEnd(count: self.arrayRepository.count, currentIndex: indexPath.row, currentRepository: self.arrayRepository[indexPath.row]) {
            self.startActivityIndicator()
            self.connect.getOtherPages()
        }
    }
}

extension RepoTableViewController: GetDataDelegate{
    func finnishingDownloadingOtherPages(slice: ArraySlice<Repository>) {
        let repositories = Array(slice)
        print("30 new elements")
        DispatchQueue.main.async {
            for repository in repositories{
                self.arrayRepository.append(repository)
            }
            self.tableView.reloadData()
        }
        self.stopActivityIndicator()
    }
    
    func finnishingDownloadindFirstPage(slice: ArraySlice<Repository>) {
        self.arrayRepository = Array(slice)
        self.tableView.reloadData()
        self.stopActivityIndicator()
    }
}
