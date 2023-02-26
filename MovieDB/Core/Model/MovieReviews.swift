//
//  MovieReviews.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Foundation

struct MovieReviews: Codable {
    let id: Int?
    let page: Int?
    let results: [ReviewResult]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
