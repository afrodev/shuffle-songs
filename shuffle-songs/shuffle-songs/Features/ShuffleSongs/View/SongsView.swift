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
    private let activityIndicator = UIActivityIndicatorView(frame: .zero)
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    convenience init() { self.init(frame: .zero) }
    
    init(frame: CGRect = .zero) {
        super.init(frame: frame, style: .plain)
        setBackgroundColor()
    }
    
    private func setBackgroundColor() {
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
    
    private func loadingState() {
        self.tableHeaderView = activityIndicator
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    private func finishState() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

extension SongsView: ViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        // Setup constraints
        self.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        self.activityIndicator.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(30)
            make.size.height.equalTo(self.activityIndicator.snp.width)
        }
        
    }
}
