//
//  ProductModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 1/1/24.
//

import Foundation

struct ProductModel: Codable {
    let name: String
    let shortDescription: String
    let fullDescription: String
    let price: Int
}

struct ResponseProduct: Codable {
    let token: String
    let refreshToken: String
    let authorities: String
    let username: String
}
