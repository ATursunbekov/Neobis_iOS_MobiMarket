//
//  ProductViewModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 29/12/23.
//

import UIKit

protocol ProductViewModelProtocol {
    var images: [UIImage] {get set}
}

class ProductViewModel: ProductViewModelProtocol {
    var images: [UIImage] = []
}
