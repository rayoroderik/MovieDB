//
//  ProductionCountry.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Foundation

struct ProductionCountry: Codable {
    let iso3166_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name = "name"
    }
}
