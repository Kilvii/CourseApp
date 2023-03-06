//
//  Assembly+bootstrapDataProvider.swift
//  CourseApp
//
//  Created by User on 06.03.2023.
//

import Foundation

extension Assembly {
    
    var bootstrapDataProvider: BootstrapDataProvider {
        BootstrapDataProvider(apiClient: apiClient)
    }
    
}
