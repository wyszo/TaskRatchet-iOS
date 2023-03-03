//
//  Data+ParseModel.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 03/03/2023.
//

import Foundation

extension Data {
    func parse<Model: Decodable>() throws -> Model {
        let model: Model
        do {
            model = try JSONDecoder().decode(Model.self, from: self)
        } catch {
            throw NetworkResponseError.responseParsingFailed
        }
        return model
    }
}
