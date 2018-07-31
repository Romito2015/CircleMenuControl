//
//  Sector.swift
//  rrrrrr
//
//  Created by Roman Chopovenko on 7/19/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

class Sector {
    var minValue: CGFloat
    var midValue: CGFloat
    var maxValue: CGFloat
    var index: Int
    
    var section: SectionView?
    
    required init(index: Int, min: CGFloat, mid: CGFloat, max: CGFloat) {
        self.index = index
        self.minValue = min
        self.midValue = mid
        self.maxValue = max
    }
}
