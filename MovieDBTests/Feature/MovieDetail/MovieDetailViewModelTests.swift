//
//  MovieDetailViewModelTests.swift
//  MovieDBTests
//
//  Created by Rayo on 27/02/23.
//

import Moya
import Nimble
import Quick

@testable import MovieDB

final class MovieDetailViewModelTests: QuickSpec {
    override func spec() {
        describe("MovieDetailViewModelTests") {
            let viewModel = MovieDetailViewModel()
            
            describe("set movie id") {
                it("should set movie id") {
                    // given
                    viewModel.movieID = nil
                    
                    // when
                    viewModel.setMovieID(id: 1)
                    
                    // then
                    expect(viewModel.movieID).to(equal(1))
                }
            }
            
            describe("fetch movie detail data") {
                context("success") {
                    beforeEach {
                        let stubbingProvider = MoyaProvider<MovieProvider>(endpointClosure: MovieProvider.successEndpointMovie,
                                                                           stubClosure: MoyaProvider.immediatelyStub)
                        let mockingService = MovieService(provider: stubbingProvider)
                        
                        viewModel.service = mockingService
                        viewModel.setMovieID(id: 1)
                    }
                    
                    it("should populate movie") {
                        // when
                        viewModel.getMovieDetail()
                        
                        // then
                        expect(viewModel.movie?.title).to(equal("Fight Club"))
                    }
                    
                    describe("get movie") {
                        it("should return movie") {
                            // given
                            viewModel.getMovieDetail()
                            
                            // when
                            let result = viewModel.getMovie()
                            
                            // then
                            expect(result?.title).to(equal("Fight Club"))
                        }
                    }
                }
                
                context("fail") {
                    beforeEach {
                        let stubbingProvider = MoyaProvider<MovieProvider>(endpointClosure: MovieProvider.failureEndpointMovie,
                                                                           stubClosure: MoyaProvider.immediatelyStub)
                        let mockingService = MovieService(provider: stubbingProvider)
                        
                        viewModel.service = mockingService
                        viewModel.setMovieID(id: 1)
                    }
                    
                    it("should return fail") {
                        // when
                        viewModel.getMovieDetail()
                        
                        // then
                        expect(viewModel.movie).to(beNil())
                        expect(viewModel.errorMessage).to(equal("Terjadi kesalahan, silahkan coba lagi."))
                    }
                    
                    describe("get error message") {
                        it("should return error message") {
                            // when
                            viewModel.getMovieDetail()
                            
                            // given
                            let result = viewModel.getErrorMessage()
                            
                            // then
                            expect(result).to(equal("Terjadi kesalahan, silahkan coba lagi."))
                        }
                    }
                }
            }
            
            describe("fetch movie reviews data") {
                context("success") {
                    
                    beforeEach {
                        let stubbingProvider = MoyaProvider<MovieProvider>(endpointClosure: MovieProvider.successEndpointMovie,
                                                                           stubClosure: MoyaProvider.immediatelyStub)
                        let mockingService = MovieService(provider: stubbingProvider)
                        
                        viewModel.service = mockingService
                        viewModel.setMovieID(id: 1)
                    }
                    
                    it("should populate reviews") {
                        // when
                        viewModel.getMovieReviews()
                        
                        // then
                        expect(viewModel.reviews).notTo(beEmpty())
                    }
                    
                    describe("get reviews") {
                        it("should return reviews") {
                            // given
                            viewModel.getMovieReviews()
                            
                            // when
                            let result = viewModel.getReviews()
                            
                            // then
                            expect(result?.count).to(equal(3))
                            expect(result?.first?.author).to(equal("Cat Ellington"))
                        }
                    }
                    
                    describe("get review count") {
                        it("should return review count") {
                            // given
                            viewModel.getMovieReviews()
                            
                            // when
                            let result = viewModel.getReviewsCount()
                            
                            // then
                            expect(result).to(equal(3))
                        }
                    }
                }
                
                context("fail") {
                    beforeEach {
                        let stubbingProvider = MoyaProvider<MovieProvider>(endpointClosure: MovieProvider.failureEndpointMovie,
                                                                           stubClosure: MoyaProvider.immediatelyStub)
                        let mockingService = MovieService(provider: stubbingProvider)
                        
                        viewModel.service = mockingService
                        viewModel.setMovieID(id: 1)
                    }
                    
                    it("should still call get videos") {
                        // when
                        viewModel.getMovieReviews()
                        
                        // then
                        
                    }
                }
            }
            
            describe("fetch movie videos data") {
                context("success") {
                    
                    beforeEach {
                        let stubbingProvider = MoyaProvider<MovieProvider>(endpointClosure: MovieProvider.successEndpointMovie,
                                                                           stubClosure: MoyaProvider.immediatelyStub)
                        let mockingService = MovieService(provider: stubbingProvider)
                        
                        viewModel.service = mockingService
                        viewModel.setMovieID(id: 1)
                    }
                    
                    it("should populate videos") {
                        // when
                        viewModel.getMovieVideos()
                        
                        // then
                        expect(viewModel.videos).notTo(beEmpty())
                    }
                    
                    describe("get video ID") {
                        it("should return video id") {
                            // given
                            viewModel.getMovieVideos()
                            
                            // when
                            let result = viewModel.getVideoID()
                            
                            // then
                            expect(result).to(equal("6JnN1DmbqoU"))
                        }
                    }
                }
                
                context("fail") {
                    beforeEach {
                        let stubbingProvider = MoyaProvider<MovieProvider>(endpointClosure: MovieProvider.failureEndpointMovie,
                                                                           stubClosure: MoyaProvider.immediatelyStub)
                        let mockingService = MovieService(provider: stubbingProvider)
                        
                        viewModel.service = mockingService
                        viewModel.setMovieID(id: 1)
                    }
                    
                    it("should still call get videos") {
                        // when
                        viewModel.getMovieVideos()
                        
                        // then
                        
                    }
                }
            }
        }
    }
}
