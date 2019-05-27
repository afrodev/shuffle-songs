//
//  SongDataMapperSpec.swift
//  shuffle-songsTests
//
//  Created by Humberto Vieira on 26/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import shuffle_songs

class SongDataMapperSpec: QuickSpec {
    
    override func spec() {
        describe("mapping result to song object") {
            context("when has a empty result", {
                it("should map no one song", closure: {
                    let songs = SongDataMapper().map(results: [])
                    expect(songs).to(beEmpty())
                })
            })
            
            context("when has one result", {
                it("should map a song", closure: {
                    let result = Result(id: 1, artistName: "name", wrapperType: "type", primaryGenreName: "genre", artistId: 2, trackName: "trackname", artworkUrl: "url")
                    
                    let songs = SongDataMapper().map(results: [result])
                    let song = songs[0]
                    
                    expect(songs.count).to(equal(1))
                    expect(song.id).to(equal(1))
                    expect(song.artistName).to(equal("name"))
                    expect(song.artworkUrl).to(equal("url"))
                    expect(song.primaryGenreName).to(equal("genre"))
                    expect(song.trackName).to(equal("trackname"))
                })
            })
        }
    }
}
