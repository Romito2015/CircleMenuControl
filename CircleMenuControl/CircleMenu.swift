//
//  CircleMenu.swift
//  CircleMenuControl
//
//  Created by Roman Chopovenko on 7/23/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

class CircleMenu: UIControl {
    
    var container: UIView!
    
    weak var delegate: CircleMenuProtocol?
    var currentSectorIndex: Int?
    var sectors = [Sector]()
    
    var menuNavigationStack = [CircleMenuSet]() {
        didSet {
            self.sectors = [Sector]()
            self.currentSectorIndex = nil
            self.container.removeFromSuperview()
            self.container = nil
            self.setNeedsDisplay()
        }
    }
    
    private var dataSource: CircleMenuSet? {
        return self.menuNavigationStack.last
    }
    
    public func updateMenu(with newMenuSet: CircleMenuSet) {
        self.menuNavigationStack.append(newMenuSet)
    }
    
    public func navigateBackInMenuStack() {
        if self.menuNavigationStack.count > 1 {
            let lastIndex = self.menuNavigationStack.count - 1
            self.menuNavigationStack.remove(at: lastIndex)
        } else {
            print("this is first element")
        }
    }
    
    private var fanWidth: CGFloat {
        guard let items = self.dataSource?.items else { return 0 }
        return (2 * .pi) / CGFloat(items.count)
    }
    
    
    
    required init(with rect: CGRect, delegate: CircleMenuProtocol, menuSet: CircleMenuSet) {
        super.init(frame: rect)
        self.delegate = delegate
        self.menuNavigationStack.append(menuSet)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var containerCenter: CGPoint = {
        return CGPoint(x: self.container.bounds.width/2, y: self.container.bounds.height/2)
    }()
    
    let separatorPadding: CGFloat = 30
    
    override func draw(_ rect: CGRect) {
        guard let items = self.dataSource?.items else { return }
        self.container = UIView(frame: rect)
        self.container.backgroundColor = .white
        
        for index in 0..<items.count {
            // Create the Sectors
            var endAngle = self.fanWidth * CGFloat(index) + self.fanWidth/2
            
            if items.count == 2 {
                endAngle = self.fanWidth * CGFloat(index)
            }
            
            let startAngle = endAngle - self.fanWidth
            let midAngle = startAngle + self.fanWidth/2
            
            let sector = Sector(with: index,
                                min: startAngle,
                                mid: midAngle,
                                max: endAngle)
            
            self.sectors.append(sector)
            
            // Draw Separator
            
            let separatorHeight: CGFloat = rect.height/2 - separatorPadding
            let separator = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 1, height: separatorHeight)))
            separator.backgroundColor = .red
            separator.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
            
            
            let separatorStartPoint = self.getPointCoordinate(withCenterIn: self.containerCenter,
                                                              radius: separatorPadding,
                                                              angle: endAngle - .pi/2)
            separator.layer.position = separatorStartPoint
            separator.transform = CGAffineTransform(rotationAngle: endAngle)
            
            self.container.addSubview(separator)
            
            // Set sector image
            
            let segment = SectionButton(with: CGRect(origin: .zero, size: CGSize(width: self.container.bounds.width, height: self.container.bounds.height/2)), model: items[index], angle: 2 * .pi - sector.midValue)
            
            segment.backgroundColor = .clear
            segment.isHighLighted = false
            
            segment.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
            segment.layer.position = CGPoint(x: self.containerCenter.x - self.container.frame.origin.x,
                                             y: self.containerCenter.y - self.container.frame.origin.y)
            segment.transform = CGAffineTransform(rotationAngle: sector.midValue)
            segment.tag = index
            
            let end: CGFloat = self.fanWidth/2
            let start: CGFloat = end - self.fanWidth
            
            self.drawSegmentPoints(inView: segment,
                                   innerPadding: self.separatorPadding,
                                   side: separatorHeight,
                                   leadingAngle: start - .pi/2,
                                   trailingAngle: end - .pi/2)
            self.container.addSubview(segment)
            sector.button = segment
        }
        
        self.container.isUserInteractionEnabled = false
        self.addSubview(self.container)
        
        // Call delegate method
        self.delegate?.segmentDidSelect("Value is: \(self.currentSectorIndex ?? -1)")
        
        // Add Central image
        let mask = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 58, height: 58)))
        mask.image = UIImage(named: "wheel")
        mask.center = CGPoint(x: self.container.center.x, y: self.container.center.y + 3)
        self.container.addSubview(mask)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint: CGPoint = touch.location(in: self)
        
        if let sector = self.detectSelectedSegment(formTouch: touchPoint) {
            self.selectSegment(atIndex: sector.sector)
        }
        return self.ignoreTaps(forTouch: touchPoint)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        self.delegate?.segmentDidSelect("Sector: \(self.currentSectorIndex ?? -1) was perssed")
        if let selectedIndex = self.currentSectorIndex, let button = self.sectors[selectedIndex].button {
            self.delegate?.didselect(self, with: button.model.parrentType)
        }
        self.deSelectSegment(atIndex: self.currentSectorIndex)
        
        
        
        
        
        
//        self.data = CircleMenuFactory().virtualGoods
    }
    
    //MARK: Private methods
    
    private func selectSegment(atIndex index: Int) {
        if let button = self.sectors[index].button {
            self.currentSectorIndex = index
            button.isHighLighted = true
        }
    }
    
    private func deSelectSegment(atIndex index: Int?) {
        if let thisIndex = index, let button = self.sectors[thisIndex].button {
            self.currentSectorIndex = nil
            button.isHighLighted = false
        }
    }
    
    private func detectSelectedSegment(formTouch touchPoint: CGPoint) -> Sector? {
        // Get inverted touch angle value
        let dx = container.center.x - touchPoint.x
        let dy = container.center.y - touchPoint.y
        let angle = -atan2(dx, dy)
        print("angle in radians: \(angle)")
        
        for sector in self.sectors {
            let newAngle = angle.toPositiveRadians
            
            let min = sector.minValue.toPositiveRadians
            let max = sector.maxValue.toPositiveRadians
            
            let regularCondition = newAngle > min.toPositiveRadians && newAngle < max
            let firstElementCondition = min > max && (newAngle > min && newAngle <= 2 * .pi || newAngle < max)
            
            if regularCondition || firstElementCondition {
                return sector
            }
        }
        return nil
    }
    
    private func calculateDistance(fromCenter point: CGPoint) -> CGFloat {
        let center = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        let dx = CGFloat(point.x - center.x)
        let dy = CGFloat(point.y - center.y)
        
        return sqrt(pow(dx, 2) + pow(dy, 2))
    }
    
    private func ignoreTaps(forTouch touchPoint: CGPoint) -> Bool {
        let dist: CGFloat = calculateDistance(fromCenter: touchPoint)
        
        if dist < self.separatorPadding || dist > self.container.bounds.width/2 {
            print("Ignoring tap \(touchPoint.x), \(touchPoint.y)")
            self.deSelectSegment(atIndex: self.currentSectorIndex)
            return false
        }
        return true
    }
    
    private func getPointCoordinate(withCenterIn center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
        return CGPoint(x: center.x + radius*cos(angle), y: center.y + radius*sin(angle))
    }
    
    private func drawSegmentPoints(inView view: UIView, innerPadding: CGFloat, side: CGFloat, leadingAngle: CGFloat, trailingAngle: CGFloat) {
        let bottomCenter = CGPoint(x: view.bounds.width/2, y: view.bounds.height)
        
        let leadingBottomPoint = self.getPointCoordinate(withCenterIn: bottomCenter,
                                                         radius: innerPadding,
                                                         angle: leadingAngle)
        let leadingTopPoint = self.getPointCoordinate(withCenterIn: bottomCenter,
                                                      radius: innerPadding + side,
                                                      angle: leadingAngle)
        
        let trailingBottomPoint = self.getPointCoordinate(withCenterIn: bottomCenter,
                                                          radius: innerPadding,
                                                          angle: trailingAngle)
        let path = UIBezierPath()
        path.move(to: leadingBottomPoint)
        path.addLine(to: leadingTopPoint)
        path.addArc(withCenter: bottomCenter, radius: innerPadding + side, startAngle: leadingAngle, endAngle: trailingAngle, clockwise: true)
        path.addLine(to: trailingBottomPoint)
        path.addArc(withCenter: bottomCenter, radius: innerPadding, startAngle: trailingAngle, endAngle: leadingAngle, clockwise: false)
        path.close()
        
        view.mask(withPath: path, inverse: false)
    }
}
