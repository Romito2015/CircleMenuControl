//
//  CircleMenuSet.swift
//  CircleMenuControl
//
//  Created by Roman Chopovenko on 7/24/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import Foundation

class CircleMenuSet {
    let title: String
    let items: [CircleMenuItem]
    
    init(with title: String, items: [CircleMenuItem]) {
        self.title = title
        self.items = items
    }
}
