//
//  SectionButton.swift
//  rrrrrr
//
//  Created by Roman Chopovenko on 7/23/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

fileprivate let iconSide: CGFloat = 34
fileprivate let padding: CGFloat = 8
fileprivate let labelHeight: CGFloat = 22
fileprivate let height = iconSide + padding + labelHeight

class SectionView: UIView {
    
    private let enabledTitleColor: UIColor = UIColor.white
    private let disabledTitleColor: UIColor = UIColor.darkGray
    
    private let enabledIconColor: UIColor = UIColor.red
    private let disabledIconColor: UIColor = UIColor.lightGray
    
    var isHighlighted: Bool = false {
        didSet {
            if let back = self.backgroundView {
                back.alpha = isHighlighted ? 1.0 : 0
            }
        }
    }
    var backgroundView: UIView!
    var buttonnContentHolder: UIView!
    var angle: CGFloat!
    var model: CircleMenuItem!
    
    required init(with frame: CGRect, model: CircleMenuItem, angle: CGFloat) {
        super.init(frame: frame)
        self.model = model
        self.angle = angle
        
        self.setupUI()
    }
    
    func setupUI() {
        self.backgroundView = self.createBackgroundView(rect: self.bounds, isHighlighted: self.isHighlighted)
        self.addSubview(self.backgroundView)
        
        let contentRect = CGRect(x: 0, y: 0, width: 2*height, height: height)
        let center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2 - 10)
        
        self.buttonnContentHolder = self.createContentView(rect: contentRect, parentCenter: center, angle: self.angle)
        self.addSubview(self.buttonnContentHolder)
        
        let iconView = self.createIconView(rect: contentRect, model: self.model)
        self.buttonnContentHolder.addSubview(iconView)
        
        let titleLabel = self.createTitleLabel(rect: contentRect, model: self.model)
        self.buttonnContentHolder.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBackgroundView(rect: CGRect, isHighlighted: Bool) -> TheGradientView {
        let view = TheGradientView(frame: rect)
        view.alpha = isHighlighted ? 1.0 : 0
        return view
    }
    
    private func createContentView(rect: CGRect, parentCenter: CGPoint, angle: CGFloat) -> UIView {
        let view = UIView(frame: rect)
        let shiftCenterY: CGFloat = 10.0
        view.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2 - shiftCenterY)
        view.backgroundColor = .clear
        view.transform = CGAffineTransform(rotationAngle: angle)
        return view
    }
    
    private func createIconView(rect: CGRect, model: CircleMenuItem) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: rect.width/2 - iconSide/2, y: 0),
                                                  size: CGSize(width: iconSide, height: iconSide)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = model.icon.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = model.isEnabled ? self.enabledIconColor : self.disabledIconColor
        return imageView
    }
    
    private func createTitleLabel(rect: CGRect, model: CircleMenuItem) -> UILabel {
        let label = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: iconSide + padding),
                                          size: CGSize(width: rect.width, height: rect.height - iconSide)))
        label.numberOfLines = 1
        label.textAlignment = .center
        let font = UIFont(name: "HelveticaNeue", size: 12)
        label.font = font
        label.text = model.title
        label.textColor = model.isEnabled ? self.enabledTitleColor : self.disabledTitleColor
        return label
    }
}
