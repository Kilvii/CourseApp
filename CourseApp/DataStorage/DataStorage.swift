//
//  DataStorage.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import Foundation

protocol DataStorage {
    
    func save<Value: Codable>(value: Value, key: String)
    
    func value<Value: Codable>(key:String) -> Value?
    
}
