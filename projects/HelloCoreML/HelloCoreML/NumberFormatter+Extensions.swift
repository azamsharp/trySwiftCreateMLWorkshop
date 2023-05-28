//
//  NumberFormatter+Extensions.swift
//  HelloCoreML
//
//  Created by Mohammad Azam on 5/19/23.
//

import Foundation

extension NumberFormatter {
    
    static var percentage: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
}
