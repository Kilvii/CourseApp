//
//  DateFormatter.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import Foundation

protocol DateFormatterProtocol {
    func string(from: Date) -> String
}

extension DateFormatter: DateFormatterProtocol {
    
}
