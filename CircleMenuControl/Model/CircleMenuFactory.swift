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
    case accessMarketplace = "Access marketplace"
    case virtualGoods = "Virtual goods"
    case stickers = "Stickers"
    case mediaContent = "Media Content"
    case groupsAndChannels = "Groups and Channels"
    case bots = "Bots"
    case apps = "Apps"
    case interpretation = "Interpretation"
    case nynjaSupport = "Support"
    case design = "Design"
    
    var icon: UIImage {
        
        switch self {
        case .freelance: return #imageLiteral(resourceName: "icon0")
        case .accessMarketplace: return #imageLiteral(resourceName: "icon1")
        case .virtualGoods: return #imageLiteral(resourceName: "icon2")
        case .stickers: return #imageLiteral(resourceName: "icon3")
        case .mediaContent: return #imageLiteral(resourceName: "icon4")
        case .groupsAndChannels: return #imageLiteral(resourceName: "icon5")
        case .bots: return #imageLiteral(resourceName: "icon6")
        case .apps: return #imageLiteral(resourceName: "icon7")
        case .interpretation: return #imageLiteral(resourceName: "icon1")
        case .nynjaSupport: return #imageLiteral(resourceName: "icon5")
        case .design: return #imageLiteral(resourceName: "icon3")
        default:return #imageLiteral(resourceName: "icon7")
        }
    }
}

class CircleMenuFactory {
    
    var marketplace: CircleMenuSet {
        let freelance = CircleMenuItem(type: .freelance, isEnabled: true)
        
        
        let accessMarketPlace = CircleMenuItem(type: .accessMarketplace, isEnabled: true)
        let virtualGoods = CircleMenuItem(type: .virtualGoods, isEnabled: true)
        
        return CircleMenuSet(title: CircleMenuItemType.marketplace.rawValue.uppercased(), items: [freelance, accessMarketPlace, virtualGoods])
    }
    
    var virtualGoods: CircleMenuSet {
        let stickers = CircleMenuItem(type: .stickers, isEnabled: false)
        let mediaContent = CircleMenuItem(type: .mediaContent, isEnabled: false)
        return CircleMenuSet(title: CircleMenuItemType.virtualGoods.rawValue.uppercased(), items: [stickers, mediaContent])
    }
    
    var accessMarketPlace: CircleMenuSet {
        let groupsAndChannels = CircleMenuItem(type: .groupsAndChannels, isEnabled: false)
        let apps = CircleMenuItem(type: .apps, isEnabled: false)
        let bots = CircleMenuItem(type: .bots, isEnabled: false)
        return CircleMenuSet(title: CircleMenuItemType.accessMarketplace.rawValue.uppercased(), items: [groupsAndChannels, apps, bots])
    }
    
    var freelance: CircleMenuSet {
        let interpretation = CircleMenuItem(type: .interpretation, isEnabled: true)
        let nynjaSupport = CircleMenuItem(type: .nynjaSupport, isEnabled: false)
        let design = CircleMenuItem(type: .design, isEnabled: false)
        return CircleMenuSet(title: CircleMenuItemType.accessMarketplace.rawValue.uppercased(), items: [interpretation, nynjaSupport, design])
    }
    
    var allElementsDictionary: [CircleMenuItemType : CircleMenuSet] {
        return [.marketplace : self.marketplace,
                .virtualGoods : self.virtualGoods,
                .accessMarketplace : self.accessMarketPlace,
                .freelance : self.freelance]
    }
    
}

