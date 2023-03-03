//
//  LoginClient.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 27/02/2023.
//

import Foundation

struct LoginClient {
    typealias FetchProfileType = (_ userID: String, _ apiToken: String) async throws -> Profile
    typealias SaveCredentialsType = (_ userID: String, _ apiToken: String) -> ()
    typealias LoadCredentialsType = () -> (String, String)

    let fetchProfile: FetchProfileType
    let saveCredentials: SaveCredentialsType
    let loadCredentials: LoadCredentialsType
}

typealias LoginClientError = NetworkResponseError

extension LoginClient {
    static let live = Self(
        fetchProfile: { userID, apiToken in
            let (data, response): (Data, URLResponse)
            do {
                let config = URLSessionConfiguration.default
                config.waitsForConnectivity = false
                config.timeoutIntervalForResource = 10
                let quickTimeoutSession = URLSession(configuration: config)

                (data, response) = try await quickTimeoutSession.data(
                    for: API.authenticatedRequestFor(.fetchProfile,
                        userID: userID,
                        apiToken: apiToken
                    )
                )
            } catch let urlError as URLError {
                throw LoginClientError(from: urlError)
            } catch {
                throw LoginClientError.requestFailed
            }
            if let error = LoginClientError(from: response) { throw error }
            return try data.parse()
        },
        saveCredentials: DataStore.live.saveCredentials,
        loadCredentials: DataStore.live.loadCredentials
    )
}
