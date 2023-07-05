//
//  Date+Extension.swift
//  test
//
//  Created by Ana Dzamelashvili on 5/18/23.
//

import Foundation
import UIKit

extension DateFormatter {
    static func formatCustomDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, HH:mm"
        return dateFormatter.string(from: date).uppercased()
    }
}


    


