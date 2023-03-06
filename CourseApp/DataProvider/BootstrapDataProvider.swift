//
//  BootstrapDataProvider.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import Foundation

final class BootstrapDataProvider {
    
    enum Error: Swift.Error {
            case unknown
        }
    
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func loadResources(completion: @escaping (Result<(profile: Profile?, city: City?), Swift.Error>) -> Void){
        
        let group = DispatchGroup()
        
        var profileResult: Result<ResponseBody<ProfileResponseData>, ApiClient.Error>?
        var cityResult: Result<ResponseBody<CityResponseData>, ApiClient.Error>?
        
        group.enter()
        apiClient.request(
            ProfileResponseData.self,
            url: Bundle.main.url(forResource: "Profile", withExtension: "json")
        ){  result in
            
            profileResult = result
            
            group.leave()
        }
        
        group.enter()
        apiClient.request(
            CityResponseData.self,
            url: Bundle.main.url(forResource: "City", withExtension: "json")
        ){  result in
            
            cityResult = result
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            guard let profileResult = profileResult, let cityResult = cityResult else {
                return
            }
            
            switch (profileResult, cityResult) {
            case (.success(let profile), .success(let city)):
                completion(.success((profile.data?.profile, city.data?.city)))
            default:
                completion(.failure(Error.unknown))
            }
        }
        
    }
}
    
