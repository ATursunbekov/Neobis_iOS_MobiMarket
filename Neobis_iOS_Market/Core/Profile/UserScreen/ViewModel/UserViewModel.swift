//
//  UserViewModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 24/12/23.
//

import Foundation

protocol UserViewModelProtocol {
    var placeholders: [String] { get set }
    var userInfo: [String]{ get set }
    var phoneNumber: String { get set }
    var userData: ProfileModel? { get set }
}

class UserViewModel: UserViewModelProtocol {
    var placeholders = ["Имя", "Фамилия", "Отчество", "Дата рождения", "Почта"]
    var userInfo: [String] = ["", "", "", "", ""]
    var phoneNumber = ""
    var userData: ProfileModel?
    
    init(userData: ProfileModel? = nil) {
        self.userData = userData
        if let name = userData?.userInfo?.name {
            userInfo[0] = name
        }
        if let lastname = userData?.userInfo?.lastname {
            userInfo[1] = lastname
        }
        
        if let middlename = userData?.userInfo?.surname {
            userInfo[2] = middlename
        }
        
        if let birthDate = userData?.userInfo?.birthDate {
            userInfo[3] = birthDate
        }
        
        if let email = userData?.email {
            userInfo[4] = email
        }
        
        if let number = userData?.phone {
            phoneNumber = number
        }
    }
}
