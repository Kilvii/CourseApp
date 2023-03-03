//
//  Assembly+ApiClient.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import Foundation

extension Assembly {
    var apiClient: ApiClient {
        ApiClient(decoder: decoder)
    }
}
