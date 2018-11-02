//
//  Repository.swift
//  Github-Repository-Swift
//
//  Created by Amine CHATATE on 11/2/18.
//  Copyright © 2018 Amine CHATATE. All rights reserved.
//

import UIKit

struct Repository: Codable {
    var name: String
    var owner: Owner
    var description: String
    var stargazers_count: Int
}
