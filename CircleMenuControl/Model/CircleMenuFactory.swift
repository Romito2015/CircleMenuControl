//
//  CircleMenuFactory.swift
//  CircleMenuControl
//
//  Created by Roman Chopovenko on 7/23/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

enum CircleMenuItemType: String {
    case marketplace = "Marketplace"
    case freelance = "Freelance"
    case accessMarketPlace = "Access marketplace"
    case virtualGoods = "Virtual goods"
    case stickers = "Stickers"
    case mediaContent = "Media Content"
    case groupsAndChannels = "Groups and Channels"
    case bots = "Bots"
    case apps = "Apps"
    case interpretation = "Interpretation"
    case nynjaSupport = "NYNJA Support"
    case design = "Design"
}

class CircleMenuFactory {
    
    var marketplace: CircleMenuSet {
        let freelance = CircleMenuItem(with: UIImage(named: "icon0")!, type: .freelance, isEnabled: true)
        
        
        let accessMarketPlace = CircleMenuItem(with: UIImage(named: "icon1")!, type: CircleMenuItemType.accessMarketPlace, isEnabled: true)
        let virtualGoods = CircleMenuItem(with: UIImage(named: "icon2")!, type: CircleMenuItemType.virtualGoods, isEnabled: true)
        
        return CircleMenuSet(with: CircleMenuItemType.marketplace.rawValue.uppercased(), items: [freelance, accessMarketPlace, virtualGoods])
    }
    
    var virtualGoods: CircleMenuSet {
        let stickers = CircleMenuItem(with: UIImage(named: "icon3")!, type: .stickers, isEnabled: false)
        let mediaContent = CircleMenuItem(with: UIImage(named: "icon4")!, type: .mediaContent, isEnabled: false)
        return CircleMenuSet(with: CircleMenuItemType.virtualGoods.rawValue.uppercased(), items: [stickers, mediaContent])
    }
    
    var accessMarketPlace: CircleMenuSet {
        let groupsAndChannels = CircleMenuItem(with: UIImage(named: "icon5")!, type: .groupsAndChannels, isEnabled: false)
        let apps = CircleMenuItem(with: UIImage(named: "icon6")!, type: .apps, isEnabled: false)
        let bots = CircleMenuItem(with: UIImage(named: "icon7")!, type: .bots, isEnabled: false)
        return CircleMenuSet(with: CircleMenuItemType.accessMarketPlace.rawValue.uppercased(), items: [groupsAndChannels, apps, bots])
    }
    
    var freelance: CircleMenuSet {
        let interpretation = CircleMenuItem(with: UIImage(named: "icon0")!, type: .interpretation, isEnabled: true)
        let nynjaSupport = CircleMenuItem(with: UIImage(named: "icon6")!, type: .nynjaSupport, isEnabled: false)
        let design = CircleMenuItem(with: UIImage(named: "icon3")!, type: .design, isEnabled: false)
        return CircleMenuSet(with: (CircleMenuItemType.accessMarketPlace.rawValue + " " + CircleMenuItemType.marketplace.rawValue).uppercased(), items: [interpretation, nynjaSupport, design])
    }
    
    var allElementsDictionary: [CircleMenuItemType : CircleMenuSet] {
        return [.marketplace : self.marketplace,
                .virtualGoods : self.virtualGoods,
                .accessMarketPlace : self.accessMarketPlace,
                .freelance : self.freelance]
    }
    
}

