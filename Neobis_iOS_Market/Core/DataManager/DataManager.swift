//
//  DataManager.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 21/12/23.
//

import Foundation

class DataManager {
    static var manager = DataManager()
    
    var token = ""
    var refreshToken = ""
    
    func setToken(token: String) {
        self.token = token
    }
    
    func setRefreshToken(token: String) {
        self.refreshToken = token
    }
    
    func getToken() -> String {
        return token
    }
    
    func getTefreshToken() -> String {
        return refreshToken
    }
}
