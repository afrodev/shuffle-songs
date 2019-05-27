//
//  SongViewModelSpec.swift
//  shuffle-songsTests
//
//  Created by Humberto Vieira on 26/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import shuffle_songs

class SongViewModelSpec: QuickSpec {
    
    private lazy var emptyRepository: SongsRepository = {
        let mock = EmptySongsRepositoryMock()
        return mock
    }()
    
    private lazy var filledRepository: SongsRepository = {
        let mock = FilledSongsRepositoryMock()
        return mock
    }()
    
    private lazy var errorRepository: SongsRepository = {
        let mock = ErrorSongsRepositoryMock()
        return mock
    }()
    
    override func spec() {
        describe("get songs from repository") {
            context("when has no one song on repository", {
                it("should return empty song list in view model", closure: {
                    let viewModel = SongsViewModel(repository: self.emptyRepository)
                    viewModel.getSongs {
                        expect(viewModel.songs).toEventually(beEmpty())
                    }
                })
            })
            
            context("when has seven songs", {
                it("should return seven songs in view model ", closure: {
                    let viewModel = SongsViewModel(repository: self.filledRepository)
                    viewModel.getSongs {
                        expect(viewModel.songs.count).toEventually(equal(7))
                    }
                })
            })
            
            context("when returns a error", {
                it("should return empty song list in view model", closure: {
                    let viewModel = SongsViewModel(repository: self.errorRepository)
                    viewModel.getSongs {
                        expect(viewModel.songs).toEventually(beEmpty())
                    }
                })
            })
        }
        
        describe("shuffle songs") {
            context("when has a empty song list ", {
                it("should return empty song list", closure: {
                    let viewModel = SongsViewModel(repository: self.emptyRepository)
                    viewModel.getSongs {
                        viewModel.shuffleSongs {
                            expect(viewModel.songs).toEventually(beEmpty())
                        }
                    }
                    
                })
            })
            
            context("when has a list of artists", {
                it("should return a song list without has the same artist sequencially", closure: {
                    let viewModel = SongsViewModel(repository: self.filledRepository)
                    viewModel.getSongs {
                        expect(viewModel.songs.count).toEventually(equal(7))
                        
                        viewModel.shuffleSongs {
                            let songs = viewModel.songs
                            expect(songs).toNotEventually(beEmpty())
                            expect(songs.count).toNotEventually(equal(1))
                            
                            var previousArtistId: Int = -1
                            for s in songs {
                                expect(s.artistId).toNot(equal(previousArtistId))
                                previousArtistId = s.artistId
                            }
                            
                        }
                    }
                })
            })
        }
    }
}
