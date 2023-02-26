//
//  AuthorDetails.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Foundation

struct AuthorDetails: Codable {
    let name: String?
    let username: String?
    let avatarPath: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case username = "username"
        case avatarPath = "avatar_path"
        case rating = "rating"
    }
}
