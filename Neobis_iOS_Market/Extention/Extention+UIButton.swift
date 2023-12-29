//
//  Extention+UIButton.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 14/12/23.
//

import Foundation
import UIKit

extension UIButton {
    func updateAppearance() {
        if isEnabled {
            backgroundColor = UIColor(hex: "#5458EA")
        } else {
            backgroundColor = UIColor(hex: "#C1C1C1")
        }
    }
    
    func updateLikeButton() {
        if self.tintColor == .gray {
            self.tintColor = .red
        } else {
            self.tintColor = .gray
        }
    }
}
