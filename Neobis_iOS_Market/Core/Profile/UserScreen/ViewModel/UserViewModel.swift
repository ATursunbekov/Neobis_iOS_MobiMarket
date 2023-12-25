//
//  UserViewModel.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 24/12/23.
//

import UIKit
 
protocol UserViewModelProtocol {
    var placeholders: [String] { get set }
    var userInfo: [String]{ get set }
    var phoneNumber: String { get set }
    var userData: ProfileModel? { get set }
    func uploadImage(image: Data)
}

class UserViewModel: UserViewModelProtocol {
    var placeholders = ["Имя", "Фамилия", "Отчество", "Дата рождения", "Почта"]
    var userInfo: [String] = ["", "", "", "", ""]
    var phoneNumber = ""
    var userData: ProfileModel?
    
    init(userData: ProfileModel? = nil) {
        self.userData = userData
        if let name = userData?.userInfo?.name {
            userInfo[0] = name
        }
        if let lastname = userData?.userInfo?.lastname {
            userInfo[1] = lastname
        }
        
        if let middlename = userData?.userInfo?.surname {
            userInfo[2] = middlename
        }
        
        if let birthDate = userData?.userInfo?.birthDate {
            userInfo[3] = birthDate
        }
        
        if let email = userData?.email {
            userInfo[4] = email
        }
        
        if let number = userData?.phone {
            phoneNumber = number
        }
    }
    
    private let url = "https://mobi-market.up.railway.app/api/user/my-photo"
    
    func uploadImage(image: Data) {
        let token = DataManager.manager.getToken()
        let boundary = "Boundary-\(UUID().uuidString)"
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "multipart/form-data; boundary=\(boundary)"]
        var body = Data()
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        body.append(image)
        body.append("\r\n")
        // Add any additional parameters if needed
        // body.append("--\(boundary)\r\n")
        // body.append("Content-Disposition: form-data; name=\"paramName\"\r\n\r\n")
        // body.append("paramValue\r\n")
        body.append("--\(boundary)--\r\n")
        
        if token != "" {
            NetworkManager.request(urlString: url,method: .post, systemBody: body, headers: header) { (result: Result<UserModel, NetworkError>)  in
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

extension Data {
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
