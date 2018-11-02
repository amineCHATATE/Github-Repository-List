//
//  UiViewExtention.swift
//  Github-Repository-Swift
//
//  Created by Amine CHATATE on 11/2/18.
//  Copyright © 2018 Amine CHATATE. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func cellAnimate() {
        self.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        self.layer.transform = transform
        UIView.animate(withDuration: 1.0) {
            self.alpha = 1.0
            self.layer.transform = CATransform3DIdentity
        }
    }
}
