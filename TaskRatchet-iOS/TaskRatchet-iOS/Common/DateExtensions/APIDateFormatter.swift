//
//  APIDateFormatter.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 10/09/2023.
//

import Foundation

extension DateFormatter {
    
    static let apiFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy, hh:mm a"
        return dateFormatter
    }()
}

extension Date {
    
    var apiFormat: String {
        DateFormatter.apiFormatter.string(from: self)
    }
}

extension String {
    
    var apiFormat: Date? {
        DateFormatter.apiFormatter.date(from: self)
    }
}
