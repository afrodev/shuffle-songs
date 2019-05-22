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
    }
    
    func setBackgroundColor() {
        self.backgroundColor = UIColor(displayP3Red: 48/255.0, green: 34/255.0, blue: 48/255.0, alpha: 1.0)
    }
    
    func state(state: LoadingState) {
        switch state {
        case .loading:
            loadingState()
        case .finish:
            finishState()
        }
    }
    
    func loadingState() {
        print("loading")
    }
    
    func finishState() {
        print("finish")
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
