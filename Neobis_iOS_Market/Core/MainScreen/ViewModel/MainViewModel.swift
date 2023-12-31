//
//  MainViewModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 27/12/23.
//

import Foundation

protocol MainDelegate: AnyObject {
    func successResponse()
}

protocol MainViewModelProtocol {
    var mainData: [MainModel]? {get set}
    var delegate: MainDelegate? {get set}
    func getUserData()
    func getFavoriteProducts()
}

class MainViewModel: MainViewModelProtocol {
    
    private let url = "https://mobi-market.up.railway.app/api/product/all?pageNumber=1&pageSize=10"
    var mainData: [MainModel]?
    var delegate: MainDelegate?
    
    func getUserData() {
        let token = DataManager.manager.getToken()
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "application/json"]
    
        if token != "" {
            NetworkManager.request(urlString: url,method: .get ,headers: header) { (result: Result<[MainModel], NetworkError>)  in
                switch result {
                case .success(let res):
                    self.mainData = res
                    self.delegate?.successResponse()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getFavoriteProducts() {
        let url = "https://mobi-market.up.railway.app/api/user/get-liked-products"
        let token = DataManager.manager.getToken()
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "application/json"]
    
        if token != "" {
            NetworkManager.request(urlString: url,method: .get ,headers: header) { (result: Result<[MainModel], NetworkError>)  in
                switch result {
                case .success(let res):
                    self.mainData = res
                    self.delegate?.successResponse()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    static func likeProduct(id: Int) {
        let url = "https://mobi-market.up.railway.app/api/user/like?id=" + String(id)
        let token = DataManager.manager.getToken()
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "application/json"]
    
        if token != "" {
            NetworkManager.request(urlString: url,method: .put ,headers: header) { (result: Result<LikeModel, NetworkError>)  in
                switch result {
                case .success(_):
                    print("Successfully liked")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
