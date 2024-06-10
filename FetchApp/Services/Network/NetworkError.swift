//
//  AppError.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/9/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidUrl
    case invalidUrlRequest
    case errorDecoding
    case badServerResponse(String)
    case noData
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "invalid url"
        case .invalidUrlRequest:
            return "invalid url request"
        case .errorDecoding:
            return "error decoding data"
        case .badServerResponse(let errorMsg):
            return "bad server response: " + errorMsg
        case .noData:
            return "uh oh. No data returned in response"
        case .unknown:
            return "an unknown networking error has occured"
        }
    }
}
