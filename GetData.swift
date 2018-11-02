//
//  GetData.swift
//  Github-Repository-Swift
//
//  Created by Amine CHATATE on 11/2/18.
//  Copyright © 2018 Amine CHATATE. All rights reserved.
//

import UIKit

protocol GetDataDelegate {
    func finnishingDownloadindFirstPage(slice: ArraySlice<Repository>)
    func finnishingDownloadingOtherPages(slice: ArraySlice<Repository>)
}
class GetData: NSObject {
    
    var delegate: GetDataDelegate?
    
    let baseUrl = "https://api.github.com/search/repositories"
    let starsQuery = "sort=stars&order=desc"
    let date = "2017-10-22"
    var page = 2
    
    var repositories: [ArraySlice<Repository>] = []
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    var url: String {
        return "\(baseUrl)?q=created:%3E\(date)&\(starsQuery)"
    }
    
    var url2: String {
        return "\(baseUrl)?q=created:%3E\(date)&\(starsQuery)&page=\(page)"
    }
    
    override init() {}
    
    func getFirstRepositoryPage() {
        if let queryUrl = URL(string: self.url) {
            DispatchQueue.main.async {
                if let data = try? Data(contentsOf: queryUrl) {
                    if let response = try? self.decoder.decode(GithubResponse.self, from: data) {
                        let slice = response.items[0...]
                        self.delegate?.finnishingDownloadindFirstPage(slice: slice)
                    }
                }
            }
        }
    }
    
    func getOtherPages() {
        if let queryUrl = URL(string: self.url2) {
            DispatchQueue.main.async {
                if let data = try? Data(contentsOf: queryUrl) {
                    if let response = try? self.decoder.decode(GithubResponse.self, from: data) {
                        let slice = response.items[0...]
                        self.page += 1
                        self.delegate?.finnishingDownloadingOtherPages(slice: slice)
                    }
                }
            }
        }
    }
}
