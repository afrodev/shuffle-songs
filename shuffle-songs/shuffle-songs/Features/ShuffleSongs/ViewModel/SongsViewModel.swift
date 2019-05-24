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
    private var songs: [Song] = []
    var reloadTableView: (() -> Void)?

    init(repository: SongsRepository = ShuffleSongsRepository()) {
        self.repository = repository
    }
    
    func getSongs() {
        repository.getSongs(onSuccess: { [weak self] (songs)  in
            guard let strongSelf = self else { return }
            strongSelf.songs = strongSelf.onlySongs(songs: songs)
            strongSelf.reloadTableView?()
        }, onError: { [weak self]  error in
            guard let strongSelf = self else { return }
            strongSelf.songs = []
            strongSelf.reloadTableView?()
        })
    }
    
    func onlySongs(songs: [Song]) -> [Song] {
        return songs.filter { (song) -> Bool in
            song.wrapperType == "track"
        }
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
