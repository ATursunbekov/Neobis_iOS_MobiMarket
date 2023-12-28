//
//  MainModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 27/12/23.
//

import Foundation


struct MainModel: Codable {
    let id: Int
    let name: String
    let price: Double
    let likes: Int
    let image: MainImage
}

struct MainImage: Codable {
    let id: Int
    let name: String
    let imageUrl: String
    let imageId: String
}
