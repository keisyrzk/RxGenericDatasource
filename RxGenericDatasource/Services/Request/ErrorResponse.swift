//
//  ErrorResponse.swift
//  RxGenericDatasource
//
//  Created by Esteban on 05.09.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import Foundation

class ErrorResponse {
    
    var errorMessage: String = ""
    var errorCode: String = ""
}

enum ErrorResponseType: Error {
    
    case badRequest(errorResponse: ErrorResponse)
    case responseError(errorResponse: ErrorResponse)
    case noData(errorResponse: ErrorResponse)
    
    var errorResponse: ErrorResponse {
        
        get {
            switch self {
            case .badRequest(errorResponse: let errorResponse),
                 .responseError(errorResponse: let errorResponse),
                 .noData(errorResponse: let errorResponse):
                return errorResponse
            }
        }
    }
}

extension ErrorResponseType: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .badRequest(errorResponse: let errorResponse),
             .responseError(errorResponse: let errorResponse),
             .noData(errorResponse: let errorResponse):
            return errorResponse.errorMessage
        }
    }
}
