//
//  RefreshTokenREquest.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 19/12/23.
//

import Foundation

struct RefreshTokenRequest: Codable {
    let token: String
    let username: String
}

struct ResponseRefreshToken: Codable {
    let accessToken: String
    let refreshToken: String
}
