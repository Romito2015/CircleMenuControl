//
//  CircleMenuItem.swift
//  CircleMenuControl
//
//  Created by Roman Chopovenko on 7/24/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

class CircleMenuItem {
    
    let parrentType: CircleMenuItemType!
    
    let icon: UIImage
    let title: String
    let isEnabled: Bool
    
    required init(with icon: UIImage, type: CircleMenuItemType, isEnabled: Bool) {
        self.icon = icon
        self.parrentType = type
        self.title = type.rawValue
        self.isEnabled = isEnabled
    }
}
