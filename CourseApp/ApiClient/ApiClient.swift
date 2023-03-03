//
//  ApiClient.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import Foundation

class ApiClient {
    
    enum Error: Swift.Error {
        case urlNotFound
        case requestFail
        case decodingFail
        
        var description: String {
            switch self {
            case .urlNotFound:
                return "URL не найден"
            case .requestFail:
                return "Данные не были получены"
            case .decodingFail:
                return "Ошибка при декодировании"
            }
        }
    }
    
    init(decoder: JSONDecoder ) {
        self.decoder = decoder
        
    }
    
    private let decoder: JSONDecoder
    
    func request<ResponseData: Decodable>(
        _ type: ResponseData.Type,
        url: URL?,
        completion: @escaping (Result<ResponseBody<ResponseData>, ApiClient.Error>) -> Void
    ) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else{
                return
            }
            
            guard let url = url else{
                self.finish(result: .failure(.urlNotFound), completion: completion)
                return
            }
            
            guard let data = try? Data.init(contentsOf: url) else {
                self.finish(result: .failure(.requestFail), completion: completion)
                return
            }
            
            guard let responseBody = try? self.decoder.decode(ResponseBody<ResponseData>.self, from: data) else {
                self.finish(result: .failure(.decodingFail), completion: completion)
                return
            }
            
            self.finish(result: .success(responseBody), completion: completion)
        }
    }
    
    private func finish<ResponseData: Decodable>(
        result: Result<ResponseBody<ResponseData>, ApiClient.Error>,
        completion: @escaping (Result<ResponseBody<ResponseData>, ApiClient.Error>) -> Void
    ) {
        DispatchQueue.main.async {
            completion(result)
        }

    }
    
}
