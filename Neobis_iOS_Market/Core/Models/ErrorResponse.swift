//
//  ErrorResponse.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 19/12/23.
//

import Foundation

struct ErrorResponse: Codable {
    let httpStatus: String
    let exceptionName: String
    let message: String
}
