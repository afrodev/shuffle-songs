//
//  Result.swift
//  shuffle-songs
//
//  Created by Humberto Vieira on 23/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import Foundation

struct Result: Decodable {
    let id: Int
    let artistName: String
    let wrapperType: String
    let primaryGenreName: String
    let artistId: Int?
    let trackName: String?
    let artworkUrl: String?
}
