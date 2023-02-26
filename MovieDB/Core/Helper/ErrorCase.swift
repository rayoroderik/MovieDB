//
//  ErrorCase.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Foundation

enum ErrorCase: Error {
    case networkError
    case notFound
    case empty
}
