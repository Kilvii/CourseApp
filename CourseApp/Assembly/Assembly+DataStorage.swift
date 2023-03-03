//
//  Assembly+DataStorage.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import Foundation

extension Assembly {
    var dataStorage: DataStorage {
        UserDefaultsStorage(encoder: JSONEncoder(), decoder: JSONDecoder(), userDefaults: UserDefaults.standard)
    }
    
    var encoder: JSONEncoder {
        JSONEncoder()
    }
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter(format: .yyyyMMdd))
        return decoder
    }
}
