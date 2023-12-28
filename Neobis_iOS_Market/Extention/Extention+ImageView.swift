//
//  Extention+ImageView.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 27/12/23.
//

import UIKit

extension UIImageView{
  func imageFrom(url:URL){
      print(url)
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url){
        if let image = UIImage(data:data){
          DispatchQueue.main.async{
            self?.image = image
          }
        }
      }
    }
  }
}
