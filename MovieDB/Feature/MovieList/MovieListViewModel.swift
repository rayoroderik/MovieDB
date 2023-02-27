//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Foundation

class MovieListViewModel {
    
    var didGetData: (() -> Void)?
    var updateErrorView: (() -> Void)?
    
    var service: MovieService = MovieService()
    var movieList: MovieList?
    var movies: [ListResult] = []
    var page = 1
    var errorMessage: String?
    
    func getMovieList() {
        service.getMovieList(page: page) { [weak self] result in
            switch result {
            case .success(let movieList):
                guard let self = self else { return }
                self.movieList = movieList
                self.movies += movieList.results ?? []
                self.errorMessage = nil
                self.didGetData?()
                self.updateErrorView?()
            case .failure:
                guard let self = self else { return }
                self.errorMessage = "Terjadi kesalahan, silahkan coba lagi."
                self.updateErrorView?()
            }
        }
    }
    
    func getListCount() -> Int {
        return movies.count
    }
    
    func getMoviesData() -> [ListResult]? {
        return movies
    }
    
    func loadNextPage() {
        page += 1
        
        getMovieList()
    }
    
    func refresh() {
        page = 1
        movies = []
        getMovieList()
    }
    
    func getErrorMessage() -> String {
        return errorMessage ?? ""
    }
}
