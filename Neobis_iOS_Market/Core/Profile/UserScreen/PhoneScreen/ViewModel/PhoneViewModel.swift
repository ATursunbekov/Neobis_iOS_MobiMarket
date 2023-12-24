//
//  PhoneViewModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 25/12/23.
//

import Foundation

protocol PhoneResponseDelegate: AnyObject {
    func successResponse(username: String, delegate: PhoneDelegate, number: String)
}

protocol PhoneViewModelProtocol {
    var localPhoneDelegate: PhoneResponseDelegate? {get set}
    func sendConfirmationCode(number: String)
}

class PhoneViewModel: PhoneViewModelProtocol {
    
    var delegate: PhoneDelegate?
    var username: String?
    
    init(delegate: PhoneDelegate, username: String) {
        self.delegate = delegate
        self.username = username
    }
    
    var localPhoneDelegate: PhoneResponseDelegate?
    var phoneNumber: String = ""
    
    private let url = "https://mobi-market.up.railway.app/api/user/send-code"
    
    func sendConfirmationCode(number: String) {
        let token = DataManager.manager.getToken()
        phoneNumber = number
        
        guard let username = username else {return}
        let body = PhoneModel(username: username, phone: number)
        
        let header = ["Authorization" : "Bearer \(token)"]
    
        if token != "" {
            NetworkManager.request(urlString: url,method: .put,body: body ,headers: header) { (result: Result<String, NetworkError>) in
                switch result {
                case .success(let res):
                    print(res)
                    guard let delegate = self.delegate else {return}
                    self.localPhoneDelegate?.successResponse(username: username, delegate: delegate, number: self.phoneNumber)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    
}
