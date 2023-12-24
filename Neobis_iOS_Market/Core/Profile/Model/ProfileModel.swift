//
//  ProfileModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 24/12/23.
//

import Foundation

struct ProfileModel: Codable {
    let username: String
    let email: String
    let userInfo: UserInfo?
    let phone: String?
    let profilePhoto: ProfilePhoto?
}

struct UserInfo: Codable {
    let name: String
    let surname: String
    let lastname: String
    let birthDate: String
}

struct ProfilePhoto: Codable {
    let name: String
    let imageUrl: String
    let imageId: String
}
