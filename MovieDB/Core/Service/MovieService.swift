//
//  MovieService.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Moya

class MovieService {
    private let provider: MoyaProvider<MovieProvider>

    public init(provider: MoyaProvider<MovieProvider> = MoyaProvider<MovieProvider>()) {
        self.provider = provider
    }

    func getMovieList(page: Int, completion: @escaping (Result<MovieList, Error>) -> Void) {
        request(target: .getMovieList(page: page), completion: completion)
    }
    
    func getMovieDetail(movieID: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        request(target: .getMovieDetail(movieID: movieID), completion: completion)
    }
    
    func getMovieReviews(movieID: Int, completion: @escaping (Result<MovieReviews, Error>) -> Void) {
        request(target: .getMovieReviews(movieID: movieID), completion: completion)
    }
    
    func getMovieVideos(movieID: Int, completion: @escaping (Result<MovieVideos, Error>) -> Void) {
        request(target: .getMovieVideos(movieID: movieID), completion: completion)
    }
}

extension MovieService {
    private func request<T: Decodable>(target: MovieProvider, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    if response.statusCode == 200 {
                        let results = try JSONDecoder().decode(T.self, from: response.data)
                        completion(.success(results))
                    } else {
                        completion(.failure(ErrorCase.networkError))
                    }
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
