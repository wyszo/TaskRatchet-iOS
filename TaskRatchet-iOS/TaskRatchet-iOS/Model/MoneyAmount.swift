//
//  MoneyAmount.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 09/09/2023.
//

import Foundation

struct MoneyAmount {
    var cents: Int
}

extension MoneyAmount {
    var dollarsRoundedDown: Int {
        cents/100
    }
    
    var dollarsRoundedDownString: String {
       "\(dollarsRoundedDown)"
    }
    
    var dollars: Float {
        (Float)(cents) * 0.01
    }
        
    var dollarsString: String {
        "\(cents / 100).\(cents % 100)$"
    }
}
