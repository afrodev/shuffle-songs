//
//  ShuffleSongsRepository.swift
//  shuffle-songs
//
//  Created by Humberto Vieira on 23/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import Foundation

enum RepositoryError: Error {
    case invalidURL
    case noData
    case mapping
}

protocol SongsRepository {
    func getSongs(onSuccess: @escaping (_ songs: [Song]) -> Void,
                  onError: @escaping (_ error: RepositoryError?) -> Void)
    func getImage(url: URL, completion: @escaping (_ data: Data?) -> Void)

}

class ShuffleSongsRepository: SongsRepository {
    private let strURL = "https://us-central1-tw-exercicio-mobile.cloudfunctions.net/lookup?id=909253,1171421960,358714030,1419227,264111789&limit=5"

    func getSongs(onSuccess: @escaping ([Song]) -> Void, onError: @escaping (RepositoryError?) -> Void) {
        guard let url = URL(string: strURL) else {
            onError(.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, reponse, error) in
            guard let songData = data else {
                onError(.noData); return
            }
            
            do {
                let data = try JSONDecoder().decode(SongWrapper.self, from: songData)
                let songs = SongDataMapper().map(results: data.results)
                onSuccess(songs)
            } catch {
                onError(.mapping)
            }
        }.resume()
    }
    
    func getImage(url: URL, completion: @escaping (_ data: Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data)
        }
        
        task.resume()
    }
}





