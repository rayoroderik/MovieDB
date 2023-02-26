//
//  MovieProvider.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Moya

enum MovieProvider {
    case getMovieList(page: Int)
    case getMovieDetail(movieID: Int)
    case getMovieReviews(movieID: Int)
    case getMovieVideos(movieID: Int)
}

extension MovieProvider: TargetType {
    
    var apiKey: String { return "09a6fd73f5ad9c5ce8de669ee1b7d91b" }
    
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .getMovieList(_):
            return "/movie/popular"
        case let .getMovieDetail(movieID):
            return "/movie/\(movieID)"
        case let .getMovieReviews(movieID):
            return "/movie/\(movieID)/reviews"
        case let .getMovieVideos(movieID):
            return "/movie/\(movieID)/videos"
        }
    }
    
    var method: Method {
        switch self {
        case .getMovieList, .getMovieDetail, .getMovieReviews, .getMovieVideos:
            return .get
        }
    }
    
    var task: Task {
        
        switch self {
        case let .getMovieList(page):
            let parameters: [String: Any] = ["api_key": apiKey,
                                             "page": page]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getMovieDetail(movieID):
            let parameters: [String: Any] = ["api_key": apiKey,
                                             "movie_id": movieID]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getMovieReviews(movieID):
            let parameters: [String: Any] = ["api_key": apiKey,
                                             "movie_id": movieID]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getMovieVideos(movieID):
            let parameters: [String: Any] = ["api_key": apiKey,
                                             "movie_id": movieID]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

