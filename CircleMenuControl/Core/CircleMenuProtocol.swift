//
//  CircleMenuProtocol.swift
//  CircleMenuControl
//
//  Created by Roman Chopovenko on 7/24/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import Foundation

protocol CircleMenuProtocol: class {
    func didselect(_ menu: CircleMenu, with type: CircleMenuItemType)
}

extension ViewController: CircleMenuProtocol {
    
    func didselect(_ menu: CircleMenu, with type: CircleMenuItemType) {
        guard let menuSet = CircleMenuFactory().allElementsDictionary[type] else {
            print("No subMenu found! Define action here")
            return
        }
        menu.updateMenu(with: menuSet)
    }
}
