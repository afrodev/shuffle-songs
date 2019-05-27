//
//  ErrorSongsRepositoryMock.swift
//  shuffle-songsTests
//
//  Created by Humberto Vieira on 26/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import Foundation

@testable import shuffle_songs

class ErrorSongsRepositoryMock: SongsRepository {
    func getSongs(onSuccess: @escaping ([Song]) -> Void, onError: @escaping (RepositoryError?) -> Void) {
        onError(.mapping)
    }
    
    func getImage(url: URL, completion: @escaping (Data?) -> Void) {
        completion(nil)
    }
}
