//
//  SectionButton.swift
//  rrrrrr
//
//  Created by Roman Chopovenko on 7/23/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

class SectionButton: UIView {
    
    var isHighLighted: Bool = false {
        didSet {
            print("isHighLighted: \(isHighLighted)")
            if let back = self.backgroundView {
                back.alpha = isHighLighted ? 1.0 : 0
            }
        }
    }
    
    var buttonnContentHolder: ButtonContent!
    
    var angle: CGFloat!
    
    var model: CircleMenuItem!
    
    required init(with frame: CGRect, model: CircleMenuItem, angle: CGFloat) {
        super.init(frame: frame)
        self.model = model
        self.angle = angle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    var backgroundView: UIView!
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.backgroundView = GradientView(frame: rect)
        self.backgroundView.alpha = self.isHighLighted ? 1.0 : 0
        
        self.addSubview(self.backgroundView)
        let iconSide: CGFloat = 70
        
        let sectorRect = CGRect(x: 0,
                                y: 0,
                                width: iconSide + 30,
                                height: iconSide)
        
        self.buttonnContentHolder = ButtonContent(with: sectorRect, icon: self.model.icon, title: self.model.title, isEnabled: model.isEnabled)
        self.buttonnContentHolder.center = CGPoint(x: rect.width/2, y: rect.height/2)
        self.buttonnContentHolder.backgroundColor = .clear
        self.buttonnContentHolder.transform = CGAffineTransform(rotationAngle: angle)
        self.addSubview(self.buttonnContentHolder)
        
    }
}

class ButtonContent: UIView {
    
    private let enabledTitleColor: UIColor = .yellow
    private let disabledTitleColor: UIColor = .darkText
    
    private let enabledIconColor: UIColor = .red
    private let disabledIconColor: UIColor = .darkGray
    
    private var iconView: UIImageView!
    private var titleLabel: UILabel!
    
    var image: UIImage!
    var title: String!
    var isEnabled: Bool!
    
    required init(with frame: CGRect, icon: UIImage, title: String, isEnabled: Bool) {
        super.init(frame: frame)
        self.image = icon
        self.title = title
        self.isEnabled = isEnabled
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let side: CGFloat = rect.height * 0.7
        self.iconView = UIImageView(frame: CGRect(origin: CGPoint(x: rect.width/2 - side/2, y: 0),
                                                  size: CGSize(width: side, height: side)))
        
        self.iconView.image = self.image.withRenderingMode(.alwaysTemplate)
        self.iconView.tintColor = self.isEnabled ? self.enabledIconColor : self.disabledIconColor
        self.addSubview(iconView)
        
        self.titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: self.iconView.bounds.height),
                                                size: CGSize(width: rect.width, height: rect.height - self.iconView.bounds.height)))
        self.titleLabel.numberOfLines = 1
        self.titleLabel.textAlignment = .center
        let font = UIFont(name: "HelveticaNeue", size: 10)
        self.titleLabel.font = font
        self.titleLabel.text = self.title
        self.titleLabel.textColor = self.isEnabled ? self.enabledTitleColor : self.disabledTitleColor
        
        self.addSubview(self.titleLabel)
    }
}
