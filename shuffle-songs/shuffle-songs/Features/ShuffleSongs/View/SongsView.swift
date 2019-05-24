//
//  SongsView.swift
//  shuffle-songs
//
//  Created by Humberto Vieira on 22/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SongsView: UITableView {
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    convenience init() { self.init(frame: .zero) }
    
    init(frame: CGRect = .zero) {
        super.init(frame: frame, style: .plain)
        setBackgroundColor()
        
        self.separatorStyle = .none
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 100
        
        self.register(SongCell.self, forCellReuseIdentifier: SongCell.identifier)
    }
    
    private func setBackgroundColor() {
        self.backgroundColor = Colors.background
    }
}

extension SongsView: ViewConfiguration {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        // Setup constraints
        self.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
