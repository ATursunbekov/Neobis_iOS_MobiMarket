//
//  MainDetailViewModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 27/12/23.
//

import UIKit

protocol MainDeatailDelegate {
    func successResponse(response: MainDetailModel)
}

protocol MainDetailViewModelProtocol {
    var id: Int? {get set}
    var mainDetailModel: MainDetailModel? {get set}
    var delegate: MainDeatailDelegate? {get set}
    func fetchProductData()
}

class MainDetailViewModel: MainDetailViewModelProtocol {
    
    var id: Int?
    var mainDetailModel: MainDetailModel?
    var delegate: MainDeatailDelegate?
    
    init(id: Int) {
        self.id = id
        fetchProductData()
    }
    
    func fetchProductData() {
        let url = "https://mobi-market.up.railway.app/api/product?id=" + String(id ?? 0)
        let token = DataManager.manager.getToken()
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "application/json"]
    
        if token != "" {
            NetworkManager.request(urlString: url, method: .get, headers: header) { (result: Result<MainDetailModel, NetworkError>)  in
                switch result {
                case .success(let res):
                    self.mainDetailModel = res
                    self.delegate?.successResponse(response: res)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
