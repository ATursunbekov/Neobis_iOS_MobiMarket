//
//  LoginViewModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 19/12/23.
//

import Foundation

protocol LoginDelegate: AnyObject {
    func successfullResponse()
    func failureResponse()
}

protocol LoginViewModelProtocol {
    var delegate: LoginDelegate? { get set }
    func loginUser(body: SignInUserRequest)
}

class LoginViewModel: LoginViewModelProtocol {
    
    weak var delegate: LoginDelegate?
    
    private let url = "http://mobi-market.up.railway.app/api/auth/sign-in"
    
    func loginUser(body: SignInUserRequest) {
        let header = ["Content-Type" : "application/json"]
        
        NetworkManager.request(urlString: url,body: body, headers: header) { [self] (result: Result<ResponseSignIn, NetworkError>) in
            switch result {
            case .success(let res):
                DataManager.manager.setToken(token: res.token)
                DataManager.manager.setRefreshToken(token: res.refreshToken)
                delegate?.successfullResponse()
            case .failure(let error):
                print(error)
                delegate?.failureResponse()
            }
        }
    }
}
