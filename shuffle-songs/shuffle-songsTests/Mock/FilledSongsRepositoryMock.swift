//
//  FilledSongsRepositoryMock.swift
//  shuffle-songsTests
//
//  Created by Humberto Vieira on 26/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import Foundation
@testable import shuffle_songs

class FilledSongsRepositoryMock: SongsRepository {
    func getSongs(onSuccess: @escaping ([Song]) -> Void, onError: @escaping (RepositoryError?) -> Void) {
        let song = Song(id: 11, artistName: "artistName", primaryGenreName: "genre", trackName: "track", artworkUrl: "artwork", artistId: 2)
        let songTwo = Song(id: 12, artistName: "artistName", primaryGenreName: "genre", trackName: "track", artworkUrl: "artwork", artistId: 2)
        let songThree = Song(id: 13, artistName: "artistName", primaryGenreName: "genre", trackName: "track", artworkUrl: "artwork", artistId: 3)
        
        let songFour = Song(id: 14, artistName: "artistName", primaryGenreName: "genre", trackName: "track", artworkUrl: "artwork", artistId: 3)
        
        let songFive = Song(id: 15, artistName: "artistName", primaryGenreName: "genre", trackName: "track", artworkUrl: "artwork", artistId: 3)
        let songSix = Song(id: 16, artistName: "artistName", primaryGenreName: "genre", trackName: "track", artworkUrl: "artwork", artistId: 4)
        
        let songSeven = Song(id: 17, artistName: "artistName", primaryGenreName: "genre", trackName: "track", artworkUrl: "artwork", artistId: 4)
        
        onSuccess([song, songTwo, songThree, songFour, songFive, songSix, songSeven])
    }
    
    func getImage(url: URL, completion: @escaping (Data?) -> Void) {
        completion(nil)
    }
}
