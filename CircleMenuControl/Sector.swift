//
//  Sector.swift
//  rrrrrr
//
//  Created by Roman Chopovenko on 7/19/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

class Sector: NSObject {
    var minValue: CGFloat
    var midValue: CGFloat
    var maxValue: CGFloat
    var sector: Int
    
    var button: SectionButton?
    
    required init(with sector: Int, min: CGFloat, mid: CGFloat, max: CGFloat) {
        self.minValue = min
        self.midValue = mid
        self.maxValue = max
        self.sector = sector
    }
    
    override var description: String {
        return "\(type(of: self)): \(sector), min: \(minValue.radiansToDegrees), mid: \(midValue.radiansToDegrees), max: \(maxValue.radiansToDegrees)"
    }
}
