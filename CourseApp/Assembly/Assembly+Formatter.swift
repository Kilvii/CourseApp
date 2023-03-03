//
//  Assembly+Formatter.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import Foundation

extension Assembly{
    
    enum DateFormat: String {
        case yyyyMMdd = "yyyy-MM-dd"
        case HHmmss = "HH:mm:ss"
        
    }
    
    func dateFormatter(format: DateFormat) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter
    }
    
}
