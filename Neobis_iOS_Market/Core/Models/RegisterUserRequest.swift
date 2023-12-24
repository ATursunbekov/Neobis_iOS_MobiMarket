//
//  SignUpUserrequest.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 19/12/23.
//

import Foundation

struct RegisterUserRequest: Codable {
    let email: String
    let username: String
    let password: String
}
