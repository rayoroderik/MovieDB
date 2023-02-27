//
//  MockData.swift
//  MovieDBTests
//
//  Created by Rayo on 27/02/23.
//

import Foundation

enum MockDataType: String {
    case mockMovieListResponse = "MockMovieListResponse"
    case mockMovieDetailResponse = "MockMovieDetailResponse"
    case mockMovieReviewsResponse = "MockMovieReviewsResponse"
    case mockMovieVideosResponse = "MockMovieVideosResponse"
}

class MockData {
    
    static func getMockRawData(type: MockDataType) -> Data {
        return readLocalFile(forName: type.rawValue) ?? Data()
    }
    
    static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle(for: MockData.self).path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
