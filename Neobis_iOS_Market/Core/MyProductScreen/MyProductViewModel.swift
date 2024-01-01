//
//  MyProductViewModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 31/12/23.
//

import Foundation

protocol MyProductDelegate: AnyObject {
    func successResponse()
}

protocol MyProductViewModelProtocol {
    var delegate: MyProductDelegate? {get set}
    var mainData: [MainModel]? {get set}
    func getUserProduct()
    func deleteProduct(id: Int)
}

class MyProductViewModel: MyProductViewModelProtocol {
    var delegate: MyProductDelegate?
    var mainData: [MainModel]?
    
//    let url = "https://mobi-market.up.railway.app/api/user/get-personal-products"
    let url = "https://mobi-market.up.railway.app/api/product/all?pageNumber=1&pageSize=10"
    
    func getUserProduct() {
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
    
    func deleteProduct(id: Int) {
        var url = "http://mobi-market.up.railway.app/api/product?id=\(id)"
        let token = DataManager.manager.getToken()
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "application/json"]
    
        if token != "" {
            NetworkManager.request(urlString: url, method: .delete ,headers: header) { (result: Result<String, NetworkError>)  in
                switch result {
                case .success(let res):
                    print(res)
                    self.delegate?.successResponse()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
