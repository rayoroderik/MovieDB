//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Foundation

class MovieDetailViewModel {
    
    var didGetData: (() -> Void)?
    
    var service: MovieService = MovieService()
    
    var movieID: Int?
    var movie: Movie?
    var reviews: [ReviewResult] = []
    var videos: [VideoResult] = []
    
    func setMovieID(id: Int) {
        movieID = id
    }
    
    func getMovieDetail() {
        guard let movieID = movieID else { return }
        service.getMovieDetail(movieID: movieID) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                guard let self = self else { return }
                self.movie = movieDetail
                self.getMovieReviews()
            case .failure(let error):
                guard let self = self else { return }
                print(error)
                print(error.localizedDescription)
            }
        }
    }
    
    func getMovie() -> Movie? {
        return movie
    }
    
    func getMovieReviews() {
        guard let movieID = movieID else { return }
        service.getMovieReviews(movieID: movieID) { [weak self] result in
            switch result {
            case .success(let reviews):
                guard let self = self else { return }
                self.reviews = reviews.results ?? []
                self.getMovieVideos()
            case .failure(let error):
                guard let self = self else { return }
                print(error)
                print(error.localizedDescription)
                self.getMovieVideos()
            }
        }
    }
    
    func getReviews() -> [ReviewResult]? {
        return reviews
    }
    
    func getReviewsCount() -> Int {
        return reviews.count
    }
    
    func getMovieVideos() {
        guard let movieID = movieID else { return }
        service.getMovieVideos(movieID: movieID) { [weak self] result in
            switch result {
            case .success(let videos):
                guard let self = self else { return }
                self.videos = videos.results ?? []
                self.didGetData?()
            case .failure(let error):
                guard let self = self else { return }
                print(error)
                print(error.localizedDescription)
                self.didGetData?()
            }
        }
    }
    
    func getVideoID() -> String? {
        return videos.first?.key
    }
}
