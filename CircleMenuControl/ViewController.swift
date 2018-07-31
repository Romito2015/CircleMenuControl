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
    var circleMenu: CircleMenu!
    var backButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.addMenuControl()
        self.addBackButton()
    }
    
    func addMenuControl() {
        let rect = CGRect(origin: .zero, size: CGSize(width: side, height: side))
        let control = CircleMenu(rect: rect, delegate: self, menuSet: CircleMenuFactory().marketplace)
        control.center = self.view.center
        self.circleMenu =  control
        self.view.addSubview(control)
    }
    
    func addBackButton() {
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 64, width: 50, height: 30)
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(.red, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonAction), for: .touchUpInside)
        backButton.layer.borderColor = UIColor.red.cgColor
        backButton.layer.borderWidth = 1.0
        self.view.addSubview(backButton)
    }
    
    @objc func backButtonAction() {
        let canNavigateBackInsideControl = self.circleMenu.navigateBackInMenuStack()
        if canNavigateBackInsideControl == false {
            //Dismiss VC
        }
    }
}

extension UIViewController: CircleMenuDelegate {
    func didSelectItem(_ menu: CircleMenu, type: CircleMenuItemType) {
        guard let menuSet = CircleMenuFactory().allElementsDictionary[type] else { return }
        menu.updateMenu(with: menuSet)
    }
    
    func didChangeCurrentSet(_ menu: CircleMenu, title: String) {
        self.title = title
    }
    
    
}
