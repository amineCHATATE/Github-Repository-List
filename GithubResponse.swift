//
//  GithubResponse.swift
//  Github-Repository-Swift
//
//  Created by Amine CHATATE on 11/2/18.
//  Copyright © 2018 Amine CHATATE. All rights reserved.
//

import Foundation

struct GithubResponse: Codable {
    var total_count: Int32
    var incomplete_results: Bool
    var items: [Repository]
}
