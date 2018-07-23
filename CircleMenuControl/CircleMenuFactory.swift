//
//  CircleMenuFactory.swift
//  CircleMenuControl
//
//  Created by Roman Chopovenko on 7/23/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

class CircleMenuFactory {
    
    struct Strings {
        static let marketplace = "Marketplace"
        static let freelance = "Freelance"
        static let accessMarketPlace = "Access marketplace"
        static let virtualGoods = "Virtual goods"
        static let stickers = "Stickers"
        static let mediaContent = "Media Content"
        static let groupsAndChannels = "Groups and Channels"
        static let bots = "Bots"
        static let apps = "Apps"
        static let interpretation = "Interpretation"
        static let nynjaSupport = "NYNJA Support"
        static let design = "Design"
    }
    
    var marketplace: CircleMenuSet {
        let freelance = CircleMenuItem(with: UIImage(named: "icon0")!, title: Strings.freelance, isEnabled: true)
        let accessMarketPlace = CircleMenuItem(with: UIImage(named: "icon1")!, title: Strings.accessMarketPlace, isEnabled: true)
        let virtualGoods = CircleMenuItem(with: UIImage(named: "icon2")!, title: Strings.virtualGoods, isEnabled: true)
        
        return CircleMenuSet(with: "MARKETPLACE", items: [freelance, accessMarketPlace, virtualGoods])
    }
    
    var virtualGoods: CircleMenuSet {
        let stickers = CircleMenuItem(with: UIImage(named: "icon3")!, title: Strings.stickers, isEnabled: false)
        let mediaContent = CircleMenuItem(with: UIImage(named: "icon4")!, title: Strings.mediaContent, isEnabled: false)
        return CircleMenuSet(with: Strings.virtualGoods.uppercased(), items: [stickers, mediaContent])
    }
    
    var accessMarketPlace: CircleMenuSet {
        let groupsAndChannels = CircleMenuItem(with: UIImage(named: "icon5")!, title: Strings.groupsAndChannels, isEnabled: false)
        let apps = CircleMenuItem(with: UIImage(named: "icon6")!, title: Strings.apps, isEnabled: false)
        let bots = CircleMenuItem(with: UIImage(named: "icon7")!, title: Strings.bots, isEnabled: false)
        return CircleMenuSet(with: Strings.accessMarketPlace.uppercased(), items: [groupsAndChannels, apps, bots])
    }
    
    var freelance: CircleMenuSet {
        let interpretation = CircleMenuItem(with: UIImage(named: "icon0")!, title: Strings.interpretation, isEnabled: true)
        let nynjaSupport = CircleMenuItem(with: UIImage(named: "icon6")!, title: Strings.nynjaSupport, isEnabled: false)
        let design = CircleMenuItem(with: UIImage(named: "icon3")!, title: Strings.design, isEnabled: false)
        return CircleMenuSet(with: (Strings.accessMarketPlace + " " + Strings.marketplace).uppercased(), items: [interpretation, nynjaSupport, design])
    }
}

