//
//  ResponseBody.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import Foundation

struct ResponseBody<ApiData: Decodable> : Decodable {
    let data: ApiData?
    let error: ApiError?
}
