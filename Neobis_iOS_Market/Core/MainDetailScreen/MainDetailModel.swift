//
//  MainDetailModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 27/12/23.
//

import Foundation

struct MainDetailModel: Codable {
    let id: Int
    let name: String
    let shortDescription: String
    let fullDescription: String
    let price: Double
    let likes: Int
}
