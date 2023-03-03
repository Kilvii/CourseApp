//
//  Profile.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import Foundation

struct Profile: Codable {
    typealias ID = String
    
    let id: ID
    let firstName: String
    let lastName: String
    let birthDay: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case birthDay = "happyday"
    }
}
