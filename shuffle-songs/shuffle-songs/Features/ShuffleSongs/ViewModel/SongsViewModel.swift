//
//  SongsViewModel.swift
//  shuffle-songs
//
//  Created by Humberto Vieira on 23/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import Foundation
import UIKit

class SongsViewModel: NSObject {
    private let repository: SongsRepository
    var songs: [Song] = []
    
    init(repository: SongsRepository = ShuffleSongsRepository()) {
        self.repository = repository
    }
    
    func getSongs(completion: @escaping () -> Void) {
        repository.getSongs(onSuccess: { [weak self] (songs)  in
            guard let strongSelf = self else { return }
            strongSelf.songs = songs
            completion()
            
            }, onError: { [weak self] error in
                guard let strongSelf = self else { return }
                strongSelf.songs = []
                print(error)
                completion()
        })
    }
    
    func shuffleSongs(completion: @escaping () -> Void) {
        self.songs = self.shuffle(songs: self.songs)
        completion()
    }
    
    private func shuffle(songs: [Song]) -> [Song] {
        var dict: [Int: [Song]] = [:]
        let allSongsNumber = songs.count
        var shuffledSongs: [Song] = []
        
        // Put on dictionary | O(n)
        for s in songs {
            let key = s.artistId
            let list = dict[key]
            
            // If don't have any value on dictionary just add it
            if var updatedList = list {
                updatedList.append(s)
                dict.updateValue(updatedList, forKey: key)
            } else {
                dict.updateValue([s], forKey: key)
            }
        }
        
        // Get randomically from dictionary the key and the value
        // removing each one
        var i = 0
        var previousArtistId: Int = -1
        
        // O(n)
        while i < allSongsNumber {
            // Get the artist randomically
            if let randomArtist = dict.randomElement() {
                // Verify if the artist is the same that before,
                // if it is get another
                if randomArtist.key != previousArtistId {
                    previousArtistId = randomArtist.key
                    
                    // Get song randomically
                    if let randomSong = randomArtist.value.randomElement() {
                        var newSongList = randomArtist.value
                        shuffledSongs.append(randomSong)
                        
                        // Remove from list and update dict
                        newSongList.removeAll{ $0.id == randomSong.id }
                        
                        // If don't exist songs, the artist no needed anymore
                        if newSongList.count == 0 {
                            dict.removeValue(forKey: randomArtist.key)
                        } else {
                            dict.updateValue(newSongList, forKey: randomArtist.key)
                        }
                        
                        // increase one
                        i += 1
                    }
                }
            }
            
            
            
        }
        
        
        return shuffledSongs
        
    }
    
    func getSongInfo(indexPath: IndexPath) -> (trackName: String, artistGenre: String, artworkURL: String) {
        let song = songs[indexPath.row]
        let trackName = song.trackName ?? ""
        let artistGenre = song.artistName + " (" + song.primaryGenreName + ") "
        let url = song.artworkUrl ?? ""
        
        return (trackName, artistGenre, url)
    }
    
    func getImage(strURL: String, completion: @escaping (_ image: UIImage) -> Void) {
        guard let url = URL(string: strURL) else { return }
        
        self.repository.getImage(url: url) { (data) in
            guard let imageData = data else {
                completion(UIImage())
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                completion(UIImage())
                return
            }
            
            completion(image)
        }
    }
}

extension SongsViewModel: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.identifier, for: indexPath) as? SongCell else {
            return UITableViewCell()
        }
        
        let info = getSongInfo(indexPath: indexPath)
        cell.setupText(trackName: info.trackName, artistGenre: info.artistGenre)
        
        getImage(strURL: info.artworkURL) { (image) in
            cell.setupImage(image: image)
        }
        
        cell.setupViewConfiguration()
        
        return cell
    }
    
}
