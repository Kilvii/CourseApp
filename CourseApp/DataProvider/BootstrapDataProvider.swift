//
//  BootstrapDataProvider.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import Foundation

class BootstrapDataProvider {
    
    private let apiClient: ApiClient
    private let group: DispatchGroup
    
    init(apiClient: ApiClient, group: DispatchGroup) {
        self.apiClient = apiClient
        self.group = group
    }
    
    func requestProfileAndCity<Model: IntermediateModel>
    (model: Model, completion: @escaping (Model) -> Void)
    {
        var intermediateModel = model
        
        group.enter()
        apiClient.request(
            ProfileResponseData.self,
            url: Bundle.main.url(forResource: "Profile", withExtension: "json")
        ) {
            [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                intermediateModel.profile = data.data?.profile
                print("Profile received")
            case .failure(let error):
                print("You have a \(error)")
            }
            self.group.leave()
        }
        
        group.enter()
        apiClient.request(
            CityResponseData.self,
            url: Bundle.main.url(forResource: "City", withExtension: "json")
        ) {
            [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                intermediateModel.city = data.data?.city
                print("City received")
            case .failure(let error):
                print("You have a \(error)")
            }
            self.group.leave()
        }
        
        group.notify(queue: .main){
            completion(intermediateModel)
        }
    }
}
