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
        self.addBackButton()
    }
    
    func addMenuControl() {
        self.circleControl =  CircleMenu(with: CGRect(origin: .zero, size: CGSize(width: side, height: side)),
                                         delegate: self,
                                         menuSet: CircleMenuFactory().marketplace)
        self.view.addSubview(circleControl!)
    }
    
    func addBackButton() {
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 350, width: 50, height: 30)
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(.red, for: .normal)
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
