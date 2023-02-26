//
//  MovieVideos.swift
//  MovieDB
//
//  Created by Rayo on 27/02/23.
//

import Foundation

struct MovieVideos: Codable {
    let id: Int?
    let results: [VideoResult]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"
    }
}
