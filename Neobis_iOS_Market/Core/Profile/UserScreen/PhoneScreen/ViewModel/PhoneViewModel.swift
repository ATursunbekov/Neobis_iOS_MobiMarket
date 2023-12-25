//
//  PhoneViewModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 25/12/23.
//

import Foundation

protocol PhoneResponseDelegate: AnyObject {
    func successResponse()
}

protocol PhoneConfirmationDelegate: AnyObject {
    func confirmationSuccessResponse(phone: String)
    func confirmationFailureResponse()
}

protocol PhoneViewModelProtocol {
    var localPhoneDelegate: PhoneResponseDelegate? {get set}
    func sendConfirmationCode(number: String)
    
    //confirmation screen data
    var confirmationDelegate: PhoneConfirmationDelegate? {get set}
    func checkConfirmationNumber(code: String)
    func sendConfirmationCode()
    
    var delegate: PhoneDelegate? {get set}
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
    
    //confirmation screen data
    var confirmationDelegate: PhoneConfirmationDelegate?
    
    func sendConfirmationCode(number: String) {
        let token = DataManager.manager.getToken()
        phoneNumber = number
        
        guard let username = username else {return}
        let body = PhoneModel(username: username, phone: number)
        
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "application/json"]
    
        if token != "" {
            NetworkManager.request(urlString: url,method: .put,body: body ,headers: header) { (result: Result<String, NetworkError>) in
                switch result {
                case .success(let res):
                    print(res)
                    guard let delegate = self.delegate else {return}
                    self.localPhoneDelegate?.successResponse()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    //ConfirmationScreen

    func checkConfirmationNumber(code: String) {
        let confirmationurl = "https://mobi-market.up.railway.app/api/user/phone-confirm?code=\(code)"
        let token = DataManager.manager.getToken()
        
        guard let username = username else {return}
        let body = PhoneModel(username: username, phone: phoneNumber)
        
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "application/json"]
    
        if token != "" {
            NetworkManager.request(urlString: confirmationurl,method: .put, body: body ,headers: header) { (result: Result<ConfirmationResponse, NetworkError>) in
                switch result {
                case .success(let res):
                    print(res)
                    self.confirmationDelegate?.confirmationSuccessResponse(phone: res.output)
                case .failure(let error):
                    print(error)
                    self.confirmationDelegate?.confirmationFailureResponse()
                }
            }
        }
    }
    
    func sendConfirmationCode() {
        let token = DataManager.manager.getToken()
        
        guard let username = username else {return}
        let body = PhoneModel(username: username, phone: phoneNumber)
        
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "application/json"]
    
        if token != "" {
            NetworkManager.request(urlString: url,method: .put,body: body ,headers: header) { (result: Result<String, NetworkError>) in
                switch result {
                case .success(let res):
                    print(res)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
