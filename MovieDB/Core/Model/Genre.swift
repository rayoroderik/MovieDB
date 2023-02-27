//
//  Genre.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Foundation

struct Genre: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
