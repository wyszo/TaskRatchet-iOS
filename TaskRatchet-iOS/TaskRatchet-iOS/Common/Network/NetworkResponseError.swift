//
//  NetworkResponseError.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 28/02/2023.
//

import Foundation

enum NetworkResponseError: Error {
    case authenticationFailed
    case noInternet
    case requestFailed
    case responseParsingFailed
}

extension NetworkResponseError {
    public init(from urlError: URLError) {
        if NetworkResponseHandler.isNoConnectionError(urlError: urlError) {
            self = .noInternet
        }
        self = .requestFailed
    }

    public init?(from urlResponse: URLResponse) {
        if NetworkResponseHandler.isAuthError(urlResponse: urlResponse) {
            self = .authenticationFailed
        }
        return nil
    }
}

private enum NetworkResponseHandler {
    static func isNoConnectionError(urlError: URLError) -> Bool {
        if [.notConnectedToInternet,
            .networkConnectionLost
        ].contains(urlError.code) {
            return true
        }
        return false
    }

    static func isAuthError(urlResponse: URLResponse) -> Bool {
        if let httpResponse = urlResponse as? HTTPURLResponse {
            if httpResponse.statusCode == 403 {
                return true
            }
        }
        return false
    }
}
