//
//  ViewController.swift
//  CircleMenuControl
//
//  Created by Roman Chopovenko on 7/23/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let side: CGFloat = 300
    var label = UILabel()
    var circleControl: CircleMenu?
    var backButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.addMenuControl()
        self.addLabel()
        self.addBackButton()
    }
    
    func addMenuControl() {
        self.circleControl =  CircleMenu(with: CGRect(origin: .zero, size: CGSize(width: side, height: side)),
                                         delegate: self,
                                         menuSet: CircleMenuFactory().marketplace)
        self.view.addSubview(circleControl!)
    }
    
    func addLabel() {
        self.label = UILabel(frame: CGRect(x: 100, y: 350, width: 200, height: 30))
        self.label.textAlignment = .center
        self.label.backgroundColor = .lightGray
        self.view.addSubview(label)
    }
    
    func addBackButton() {
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 350, width: 50, height: 30)
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(.green, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonAction), for: .touchUpInside)
        backButton.layer.borderColor = UIColor.red.cgColor
        backButton.layer.borderWidth = 1.0
        self.view.addSubview(backButton)
    }
    
    @objc func backButtonAction() {
        if let menu = self.circleControl {
            menu.navigateBackInMenuStack()
        }
    }
    
}

protocol CircleMenuProtocol: class {
    func segmentDidSelect(_ newValue: String)
    func didselect(_ menu: CircleMenu, with type: CircleMenuItemType)
}

extension ViewController: CircleMenuProtocol {
    func segmentDidSelect(_ newValue: String) {
        self.label.text = newValue
    }
    
    func didselect(_ menu: CircleMenu, with type: CircleMenuItemType) {
        guard let menuSet = CircleMenuFactory().allElementsDictionary[type] else {
            print("No subMenu found! Define action here")
            return
        }
        menu.updateMenu(with: menuSet)
    }
}

class CircleMenuSet {
    let title: String
    let items: [CircleMenuItem]
    
    init(with title: String, items: [CircleMenuItem]) {
        self.title = title
        self.items = items
    }
}



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
