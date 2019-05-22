//
//  ViewConfiguration.swift
//  shuffle-songs
//
//  Created by Humberto Vieira on 22/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import Foundation

public protocol ViewConfiguration {
    func setupViewConfiguration()
    func setupConstraints()
    func buildViewHierarchy()
}

public extension ViewConfiguration {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
    }
}
