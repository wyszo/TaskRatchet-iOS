//
//  Date+Convenience.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 10/09/2023.
//

import Foundation

extension Date {
    var dateByAddingDay: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var dateByAddingWeek: Date {
        Calendar.current.date(byAdding: .day, value: 7, to: self)!
    }
    
    var dateByAddingMonth: Date {
        Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }
}

extension Date {
    
    static var dayFromNow : Date {
        Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    }
    
    static var weekFromNow : Date {
        Calendar.current.date(byAdding: .day, value: 7, to: Date())!
    }
    
    static var monthFromNow : Date {
        Calendar.current.date(byAdding: .month, value: 1, to: Date())!
    }
}
