//
//  MovieList.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Foundation

struct MovieList: Codable {
    let page: Int?
    let results: [ListResult]?
    let totalResults: Int?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
