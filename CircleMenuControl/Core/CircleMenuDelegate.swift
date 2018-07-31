//
//  CircleMenuDelegate.swift
//  CircleMenuControl
//
//  Created by Roman Chopovenko on 7/24/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import Foundation

protocol CircleMenuDelegate: class {
    func didSelectItem(_ menu: CircleMenu, type: CircleMenuItemType)
    func didChangeCurrentSet(_ menu: CircleMenu, title: String)
}
