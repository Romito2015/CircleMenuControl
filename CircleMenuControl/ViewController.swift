//
//  ViewController.swift
//  CircleMenuControl
//
//  Created by Roman Chopovenko on 7/23/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label = UILabel(frame: CGRect(x: 100, y: 350, width: 200, height: 30))
        self.label.textAlignment = .center
        self.label.backgroundColor = .lightGray
        self.view.addSubview(label)
        
        let side: CGFloat = 200
        
        let circleControl =  CircleMenu(with: CGRect(origin: .zero, size: CGSize(width: side, height: side)),
                                        delegate: self,
                                        menuSet: CircleMenuFactory().marketplace)
        self.view.addSubview(circleControl)
        
    }
    
    
}



protocol CircleMenuProtocol: class {
    func segmentDidSelect(_ newValue: String)
}

extension ViewController: CircleMenuProtocol {
    func segmentDidSelect(_ newValue: String) {
        self.label.text = newValue
    }
}

typealias EmptyAction = () -> ()

class CircleMenuSet {
    let title: String
    let items: [CircleMenuItem]
    
    init(with title: String, items: [CircleMenuItem]) {
        self.title = title
        self.items = items
    }
    
}

class CircleMenuItem {
    let icon: UIImage
    let title: String
    let isEnabled: Bool
    
    required init(with icon: UIImage, title: String, isEnabled: Bool) {
        self.icon = icon
        self.title = title
        self.isEnabled = isEnabled
    }
}







