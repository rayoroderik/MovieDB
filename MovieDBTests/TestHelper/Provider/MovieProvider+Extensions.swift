//
//  MovieProvider+Extensions.swift
//  MovieDBTests
//
//  Created by Rayo on 27/02/23.
//

import Moya

@testable import MovieDB

extension MovieProvider {
    var testSampleDataMovie: Data {
        switch self {
        case .getMovieList(_):
            return MockData.getMockRawData(type: .mockMovieListResponse)
        case .getMovieDetail(_):
            return MockData.getMockRawData(type: .mockMovieDetailResponse)
        case .getMovieReviews(_):
            return MockData.getMockRawData(type: .mockMovieReviewsResponse)
        case .getMovieVideos(_):
            return MockData.getMockRawData(type: .mockMovieVideosResponse)
        }
    }

    static func successEndpointMovie(target: MovieProvider) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.testSampleDataMovie) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }

    static func failureEndpointMovie(target: MovieProvider) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkError(
                            NSError(
                                domain: "com.rayo",
                                code: 401,
                                userInfo: [NSLocalizedDescriptionKey: "test error"])
                        )},
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
}
