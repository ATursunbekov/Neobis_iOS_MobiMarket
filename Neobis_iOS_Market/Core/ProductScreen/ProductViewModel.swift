//
//  ProductViewModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 29/12/23.
//

import UIKit

protocol ProductDelegate {
    func success()
}

protocol ProductViewModelProtocol {
    var images: [UIImage] {get set}
    var delegate: ProductDelegate? {get set}
    func uploadImagesAndJson(additionalParameters: [String: String])
    func updateProductData(body: ProductModel, id: Int)
}

class ProductViewModel: ProductViewModelProtocol {
    var images: [UIImage] = []
    var delegate: ProductDelegate?
    
    let url = "https://mobi-market.up.railway.app/api/product"
    
    
    func uploadImagesAndJson(additionalParameters: [String: String]) {
//    jsonFile: Data
        var images: [Data] = []
        for i in self.images {
            if let imageData = i.jpegData(compressionQuality: 0.1) {
                images.append(imageData)
            }
        }
        
        let jsonString = convertDictionaryToString(dictionary: additionalParameters)
        
        let url = "https://mobi-market.up.railway.app/api/user/my-photo"
        let token = DataManager.manager.getToken()
        let boundary = "Boundary-\(UUID().uuidString)"
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "multipart/form-data; boundary=\(boundary)"]
        var body = Data()
        
        // Append images to the request body
        for image in images {
            body.append("\r\n--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n")
            body.append("Content-Type: image/jpeg\r\n\r\n")
            body.append(image)
            body.append("\r\n")
        }
        if let jsonData = jsonString?.data(using: .utf8) {
            // Append JSON file to the request body
            body.append("\r\n--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"file_json\"; filename=\"data.json\"\r\n")
            body.append("Content-Type: application/json\r\n\r\n")
            body.append(jsonData)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        
        if token != "" {
            NetworkManager.request(urlString: url, method: .post, systemBody: body, headers: header) { (result: Result<String, NetworkError>)  in
                switch result {
                case .success(_):
                    self.delegate?.success()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func updateProductData(body: ProductModel, id: Int) {
        let url = "http://mobi-market.up.railway.app/api/product?id=\(id)"
        let token = DataManager.manager.getToken()
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "application/json"]
        
        NetworkManager.request(urlString: url, method: .put, body: body,headers: header) { (result: Result<ResponseProduct, NetworkError>)  in
            switch result {
            case .success(_):
                self.delegate?.success()
            case .failure(let error):
                print(error)
            }
        }
    }

    func convertDictionaryToString(dictionary: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            print("Error converting dictionary to string: \(error)")
            return nil
        }
    }
}

