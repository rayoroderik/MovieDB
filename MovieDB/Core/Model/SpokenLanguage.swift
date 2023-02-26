//
//  SpokenLanguage.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Foundation

struct SpokenLanguage: Codable {
    let iso639_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name = "name"
    }
}
