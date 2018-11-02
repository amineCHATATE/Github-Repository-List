//
//  RepoTableViewCell.swift
//  Github-Repository-Swift
//
//  Created by Amine CHATATE on 11/2/18.
//  Copyright © 2018 Amine CHATATE. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var NoS: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
