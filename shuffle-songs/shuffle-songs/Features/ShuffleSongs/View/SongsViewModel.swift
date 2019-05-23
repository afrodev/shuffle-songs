//
//  SongsViewModel.swift
//  shuffle-songs
//
//  Created by Humberto Vieira on 23/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import Foundation

class SongsViewModel {
    private let repository: SongsRepository
    private var songs: [Song] = []
    
    init(repository: SongsRepository = ShuffleSongsRepository()) {
        self.repository = repository
    }
    
    func getSongs() {
        repository.getSongs(onSuccess: { (songs) in
            self.songs = songs
            print(songs)
        }, onError: { error in
            print(error)
        })
    }
    
}
