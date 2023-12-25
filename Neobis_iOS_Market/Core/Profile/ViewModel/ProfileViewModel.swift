//
//  ViewModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 24/12/23.
//

import UIKit

protocol ProfileDelegate: AnyObject {
    func successfulResponse(res: ProfileModel)
}

protocol ProfileViewModelProtocol {
    var delegate: ProfileDelegate? { get set }
    var profileModel: ProfileModel? { get set }
    
    func getUserData()
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    weak var delegate: ProfileDelegate?
    var profileModel: ProfileModel?
    
    private let url = "https://mobi-market.up.railway.app/api/user"
    
    func getUserData() {
        let token = DataManager.manager.getToken()
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "application/json"]
    
        if token != "" {
            NetworkManager.request(urlString: url,method: .get ,headers: header) { (result: Result<ProfileModel, NetworkError>)  in
                switch result {
                case .success(let res):
                    self.profileModel = res
                    self.delegate?.successfulResponse(res: res)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
