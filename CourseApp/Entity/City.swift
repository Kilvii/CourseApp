//
//  City.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import Foundation

struct City: Codable {
    typealias ID = String
    
    let id: ID
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
