//
//  Assembly+DataProvider.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import Foundation

extension Assembly {
    
    var bootstrapDataProvider: BootstrapDataProvider {
        BootstrapDataProvider(apiClient: apiClient, group: group)
    }
    
}
