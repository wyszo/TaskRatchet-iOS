//
//  DataStore.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 27/02/2023.
//

import Foundation

struct DataStore {
    typealias SaveCredentialsType = (_ userID: String, _ apiToken: String) -> ()
    typealias LoadCredentialsType = () -> (String, String)
    
    let saveCredentials: SaveCredentialsType
    let loadCredentials: LoadCredentialsType
}

extension DataStore {
    static let live = userDefaultsStore
    
    private enum Key: String {
        case userID
        case apiToken
    }
    
    // TODO: move saving credentials to keychain
    private static let userDefaultsStore = Self(
        saveCredentials: { userID, apiToken in
            let save = { (value: String, key: Key) in
                UserDefaults.standard.set(value, forKey: key.rawValue)
            }
            save(userID, Key.userID)
            save(apiToken, Key.apiToken)
        },
        loadCredentials: {
            let load = { (key: Key) in
                return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
            }
            return (load(Key.userID), load(Key.apiToken))
        }
    )
}

extension DataStore {
    static let mock = Self(
        saveCredentials: { _, _ in },
        loadCredentials: { return ("UserID", "API-token")}
    )
}
