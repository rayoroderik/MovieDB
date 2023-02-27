//
//  MovieListViewModelTests.swift
//  MovieDBTests
//
//  Created by Rayo on 27/02/23.
//

import Moya
import Nimble
import Quick

@testable import MovieDB

final class MovieListModelTests: QuickSpec {
    override func spec() {
        describe("MovieListModelTests") {
            let viewModel = MovieListViewModel()
            
            describe("fetch movie list data") {
                context("success") {
                    
                    beforeEach {
                        let stubbingProvider = MoyaProvider<MovieProvider>(endpointClosure: MovieProvider.successEndpointMovie,
                                                                           stubClosure: MoyaProvider.immediatelyStub)
                        let mockingService = MovieService(provider: stubbingProvider)
                        
                        viewModel.service = mockingService
                    }
                    
                    it("should populate list") {
                        // when
                        viewModel.getMovieList()
                        
                        // then
                        expect(viewModel.movies).notTo(beEmpty())
                    }
                    
                    describe("get list count") {
                        it("should return current movie list count") {
                            // given
                            viewModel.movies = []
                            
                            // when
                            viewModel.getMovieList()
                            let result = viewModel.getListCount()
                            
                            // then
                            expect(result).to(equal(10))
                        }
                    }
                    
                    describe("get movie data") {
                        it("should return current movie list count") {
                            // given
                            viewModel.movies = []
                            
                            // when
                            viewModel.getMovieList()
                            let result = viewModel.getMoviesData()
                            
                            // then
                            expect(result).notTo(beEmpty())
                            expect(result?.count).to(equal(10))
                        }
                    }
                    
                    describe("load next page") {
                        it("should increment page and get movie list") {
                            // given
                            viewModel.movies = []
                            viewModel.page = 5
                            
                            // when
                            viewModel.loadNextPage()
                            
                            // then
                            expect(viewModel.movies).notTo(beEmpty())
                            expect(viewModel.page).to(equal(6))
                        }
                    }
                    
                    describe("refresh") {
                        it("should refresh data and load start from page 1") {
                            // given
                            viewModel.movies = []
                            viewModel.page = 5
                            
                            // when
                            viewModel.refresh()
                            
                            // then
                            expect(viewModel.movies).notTo(beEmpty())
                            expect(viewModel.page).to(equal(1))
                        }
                    }
                }
                
                context("fail") {
                    beforeEach {
                        let stubbingProvider = MoyaProvider<MovieProvider>(endpointClosure: MovieProvider.failureEndpointMovie,
                                                                           stubClosure: MoyaProvider.immediatelyStub)
                        let mockingService = MovieService(provider: stubbingProvider)
                        
                        viewModel.service = mockingService
                    }
                    
                    it("should return fail") {
                        // when
                        viewModel.getMovieList()
                        
                        // then
                        expect(viewModel.movies).to(beEmpty())
                        expect(viewModel.errorMessage).to(equal("Terjadi kesalahan, silahkan coba lagi."))
                    }
                    
                    describe("get error message") {
                        it("should return error message") {
                            // when
                            viewModel.getMovieList()
                            
                            // given
                            let result = viewModel.getErrorMessage()
                            
                            // then
                            expect(result).to(equal("Terjadi kesalahan, silahkan coba lagi."))
                        }
                    }
                }
            }
        }
    }
}
