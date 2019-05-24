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

extension SongsViewModel: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.identifier, for: indexPath) as? SongCell else {
            return UITableViewCell()
        }
        
        cell.setupViewConfiguration()
        
        return cell
    }
    
}
