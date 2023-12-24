//
//  RegisterViewModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 20/12/23.
//

import Foundation

protocol RegisterDelegate: AnyObject {
    func successResponse()
    func failurResponse()
}

protocol RegisterViewModelProtocol {
    var delegate: RegisterDelegate? { get set }
    var mail: String? { get set }
    var username: String? { get set }
    var password1: String? { get set }
    var password2: String? { get set }
    
    func setMail(input: String)
    func setusername(input: String)
    func setPassword1(input: String)
    func setPassword2(input: String)
    func registerUser()
}

class RegisterViewModel: RegisterViewModelProtocol {
    
    weak var delegate: RegisterDelegate?
    
    var mail: String?
    var username: String?
    var password1: String?
    var password2: String?
    
    func setMail(input: String) {
        mail = input
    }
    
    func setusername(input: String) {
        username = input
    }
    
    func setPassword1(input: String) {
        password1 = input
    }
    
    func setPassword2(input: String) {
        password2 = input
    }
    
    private let url = "https://mobi-market.up.railway.app/api/auth/sign-up"
    
    func registerUser() {
        if let mail = mail, let username = username, let password = password2 {
            let user = RegisterUserRequest(email: mail, username: username, password: password)
            
            NetworkManager.request(urlString: url, body: user) {[self] (result: Result<String, NetworkError>) in
                switch result {
                case .success(let res):
                    print(res)
                    delegate?.successResponse()
                case .failure(let error):
                    print(error)
                    delegate?.failurResponse()
                }
            }
        }
    }
}
