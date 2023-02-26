//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Foundation

class MovieListViewModel {
    
    var didGetData: (() -> Void)?
    
    var service: MovieService = MovieService()
    var movieList: MovieList?
    var movies: [ListResult] = []
    var page = 1
    
    func getMovieList() {
        service.getMovieList(page: page) { [weak self] result in
            switch result {
            case .success(let movieList):
                guard let self = self else { return }
                self.movieList = movieList
                self.movies += movieList.results ?? []
                self.didGetData?()
            case .failure(let error):
                guard let self = self else { return }
                print(error)
                print(error.localizedDescription)
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
}
