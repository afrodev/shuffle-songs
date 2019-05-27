//
//  Song.swift
//  shuffle-songs
//
//  Created by Humberto Vieira on 24/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import Foundation

class Song {
    let id: Int
    let artistName: String
    let primaryGenreName: String
    let trackName: String
    let artworkUrl: String
    let artistId: Int
    
    init(id: Int, artistName: String, primaryGenreName: String,
         trackName: String, artworkUrl: String, artistId: Int) {
        self.id = id
        self.artistName = artistName
        self.primaryGenreName = primaryGenreName
        self.trackName = trackName
        self.artworkUrl = artworkUrl
        self.artistId = artistId
    }
}
