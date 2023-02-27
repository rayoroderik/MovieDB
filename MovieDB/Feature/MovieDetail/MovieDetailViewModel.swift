//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Foundation

class MovieDetailViewModel {
    
    var didGetData: (() -> Void)?
    var updateErrorView: (() -> Void)?
    
    var service: MovieService = MovieService()
    
    var movieID: Int?
    var movie: Movie?
    var reviews: [ReviewResult] = []
    var videos: [VideoResult] = []
    
    var errorMessage: String?
    
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
            case .failure:
                guard let self = self else { return }
                self.errorMessage = "Terjadi kesalahan, silahkan coba lagi."
                self.updateErrorView?()
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
            case .failure:
                guard let self = self else { return }
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
                self.updateErrorView?()
            case .failure:
                guard let self = self else { return }
                self.didGetData?()
                self.updateErrorView?()
            }
        }
    }
    
    func getVideoID() -> String? {
        return videos.first?.key
    }
    
    func getErrorMessage() -> String {
        return errorMessage ?? ""
    }
}
