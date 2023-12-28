//
//  Extention+HidingTabBar.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 27/12/23.
//

import UIKit

extension CustomTabBarController {
    override var hidesBottomBarWhenPushed: Bool {
        get {
            return navigationController?.topViewController == self
        }
        set {
            super.hidesBottomBarWhenPushed = newValue
        }
    }
}
