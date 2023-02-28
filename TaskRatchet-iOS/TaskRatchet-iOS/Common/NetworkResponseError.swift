//
//  NetworkResponseError.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 28/02/2023.
//

import Foundation

enum NetworkResponseError: Error {
    case requestFailed
    case responseParsingFailed
}
