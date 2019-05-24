//
//  SongCell.swift
//  shuffle-songs
//
//  Created by Humberto Vieira on 24/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    static let identifier = "SongCell"
    lazy var imageViewArtwork: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .red
        return view
    }()
    
    lazy var labelSongName: UILabel = {
        let view = UILabel(frame: .zero)
        view.backgroundColor = .black
        return view
    }()
    
    lazy var labelArtistGenre: UILabel = {
        let view = UILabel(frame: .zero)
        view.backgroundColor = .green
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SongCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(imageViewArtwork)
        addSubview(labelSongName)
        addSubview(labelArtistGenre)
    }
    
    func setupConstraints() {
        imageViewArtwork.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        labelSongName.snp.makeConstraints { (make) in
            make.top.equalTo(imageViewArtwork.snp.top)
            make.left.equalTo(imageViewArtwork.snp.right).offset(20)
            make.height.equalTo(30)
            make.right.equalToSuperview().inset(20)
        }
        
        labelArtistGenre.snp.makeConstraints { (make) in
            make.top.equalTo(labelSongName.snp.bottom)
            make.left.equalTo(imageViewArtwork.snp.right).offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
