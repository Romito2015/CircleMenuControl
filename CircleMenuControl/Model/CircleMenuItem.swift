//
//  CircleMenuItem.swift
//  CircleMenuControl
//
//  Created by Roman Chopovenko on 7/24/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

struct CircleMenuItem {
    
    let type: CircleMenuItemType
    let isEnabled: Bool
    
    var icon: UIImage { return type.icon }
    var title: String { return type.rawValue }
}
