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

// TODO: rename to `LoginClientError`
enum LoginError: Error {
    case requestFailed
    case noInternet
    case authenticationFailed
    case responseParsingFailed
}

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
                    for: API.authenticatedRequestFor(.profile,
                        userID: userID,
                        apiToken: apiToken
                    )
                )
            } catch let error {
                if let urlError = error as? URLError {
                    if [.notConnectedToInternet,
                        .networkConnectionLost
                    ].contains(urlError.code) {
                        throw LoginError.noInternet
                    }
                }
                throw LoginError.requestFailed
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 403 {
                    throw LoginError.authenticationFailed
                }
            }

            let profile: Profile
            do {
                profile = try JSONDecoder().decode(Profile.self, from: data)
            } catch {
                throw LoginError.responseParsingFailed
            }
            return profile
        },
        saveCredentials: DataStore.live.saveCredentials,
        loadCredentials: DataStore.live.loadCredentials
    )
}
