//
//  SignInUserRequest.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 19/12/23.
//

import Foundation

struct SignInUserRequest: Codable {
    let username: String
    let password: String
}

struct ResponseSignIn: Codable {
    let token: String
    let refreshToken: String
    let authorities: String
    let username: String
}
