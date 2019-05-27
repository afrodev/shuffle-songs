//
//  SongDataMapper.swift
//  shuffle-songs
//
//  Created by Humberto Vieira on 24/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import Foundation

class SongDataMapper {
    
    func map(results: [Result]) -> [Song] {
        return results.compactMap { (result) -> Song? in
            guard let trackName = result.trackName,
                let artworkURL = result.artworkUrl,
                let artistId = result.artistId else {
                    return nil
            }
            
            let song = Song(
                id: result.id,
                artistName: result.artistName,
                primaryGenreName: result.primaryGenreName,
                trackName: trackName,
                artworkUrl: artworkURL,
                artistId: artistId)
            
            return song
        }
    }
}
