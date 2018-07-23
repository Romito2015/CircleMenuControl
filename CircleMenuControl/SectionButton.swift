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
    
    var index: Int!
    
    required init(with frame: CGRect, index: Int, angle: CGFloat) {
        super.init(frame: frame)
        self.index = index
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
        let iconSide: CGFloat = 50
        
        let sectorRect = CGRect(x: 0,
                                y: 0,
                                width: iconSide,
                                height: iconSide)
        
        let img = UIImage(named: String(format: "icon%i.png", self.index))
        self.buttonnContentHolder = ButtonContent(with: sectorRect, icon: img!, title: "\(index)")
        self.buttonnContentHolder.center = CGPoint(x: rect.width/2, y: rect.height/2 - 10)
        self.buttonnContentHolder.backgroundColor = .clear
        self.buttonnContentHolder.transform = CGAffineTransform(rotationAngle: angle)
        self.addSubview(self.buttonnContentHolder)
        
    }
}

class ButtonContent: UIView {
    
    var iconView: UIImageView!
    var titleLabel: UILabel!
    
    var image: UIImage!
    var title: String!
    
    required init(with frame: CGRect, icon: UIImage, title: String) {
        super.init(frame: frame)
        self.image = icon
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let side: CGFloat = rect.width * 0.7
        self.iconView = UIImageView(frame: CGRect(origin: CGPoint(x: rect.width/2 - side/2, y: 0),
                                                  size: CGSize(width: side, height: side)))

        self.iconView.image = self.image
        self.addSubview(iconView)
        
        self.titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: self.iconView.bounds.height), size: CGSize(width: rect.width, height: rect.height - self.iconView.bounds.height)))
        self.titleLabel.numberOfLines = 1
        self.titleLabel.textAlignment = .center
        let font = UIFont(name: "HelveticaNeue", size: 10)
        self.titleLabel.font = font
        self.titleLabel.text = self.title
        
        self.addSubview(self.titleLabel)
    }
}