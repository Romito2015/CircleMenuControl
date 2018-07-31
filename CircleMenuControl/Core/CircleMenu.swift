//
//  CircleMenu.swift
//  CircleMenuControl
//
//  Created by Roman Chopovenko on 7/23/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

class CircleMenu: UIControl {
    
    weak var delegate: CircleMenuDelegate?
    
    private var container: UIView!
    private var sectors = [Sector]()
    private(set) var currentSectorIndex: Int?
    private let separatorPadding: CGFloat = 30
    
    private var menuNavigationStack = [CircleMenuSet]() {
        didSet {
            if let data = self.dataSource {
                self.delegate?.didChangeCurrentSet(self, title: data.title)
            }
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
    
    private var containerCenter: CGPoint {
        return CGPoint(x: self.container.bounds.width/2, y: self.container.bounds.height/2)
    }
    
    private var segmentAngle: CGFloat {
        guard let items = self.dataSource?.items else { return 0 }
        return (2 * .pi) / CGFloat(items.count)
    }
    
    
    //MARK: Public methods
    
    public func updateMenu(with newMenuSet: CircleMenuSet) {
        self.menuNavigationStack.append(newMenuSet)
    }
    
    public func navigateBackInMenuStack() -> Bool {
        if self.menuNavigationStack.count > 1 {
            let lastIndex = self.menuNavigationStack.count - 1
            self.menuNavigationStack.remove(at: lastIndex)
            return true
        }
        return false
    }
    
    
    //MARK: - Init
    
    required init(rect: CGRect, delegate: CircleMenuDelegate, menuSet: CircleMenuSet) {
        super.init(frame: rect)
        self.delegate = delegate
        self.menuNavigationStack.append(menuSet)
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override
    
    override func draw(_ rect: CGRect) {
        guard let items = self.dataSource?.items else { return }
        self.container = UIView(frame: rect)
        self.container.backgroundColor = .clear
        
        for index in 0..<items.count {
            // Create the Sectors
            let sector = self.createSector(at: index, itemsCount: items.count, angle: self.segmentAngle)
            self.sectors.append(sector)
            
            // Draw Separator
            let separatorHeight: CGFloat = rect.height/2 - self.separatorPadding
            let separator = self.createSeparator(padding: self.separatorPadding,
                                                 height: separatorHeight,
                                                 angle: sector.maxValue,
                                                 center: self.containerCenter,
                                                 color: .red)
            self.container.addSubview(separator)
            
            // Set sector image
            
            let section = self.createSection(in: self.container, rotationAngle: sector.midValue, model: items[index])
            self.container.addSubview(section)
            sector.section = section
            
            let end: CGFloat = self.segmentAngle/2
            let start: CGFloat = end - self.segmentAngle
            
            self.drawSegmentPoints(inView: section,
                                   innerPadding: self.separatorPadding,
                                   side: separatorHeight,
                                   leadingAngle: start - .pi/2,
                                   trailingAngle: end - .pi/2)
        }
        
        self.container.isUserInteractionEnabled = false
        self.addSubview(self.container)
        
        // Add Central image
        let centerImage = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 58, height: 58)))
        centerImage.image = UIImage(named: "wheel")
        centerImage.center = CGPoint(x: self.container.center.x, y: self.container.center.y + 5)
        self.container.addSubview(centerImage)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint: CGPoint = touch.location(in: self)
        
        if let sector = self.detectSelectedSegment(form: touchPoint), let data = self.dataSource {
            if data.items[sector.index].isEnabled {
                self.selectSegment(at: sector.index)
            }
        }
        return self.ignoreTaps(for: touchPoint)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        if let selectedIndex = self.currentSectorIndex, let section = self.sectors[selectedIndex].section {
            self.delegate?.didSelectItem(self, type: section.model.type)
        }
        self.deSelectSegment(at: self.currentSectorIndex)
    }
    
    
    //MARK: - Construct Menu UI
    
    private func createSector(at index: Int, itemsCount: Int, angle: CGFloat) -> Sector {
        var endAngle = self.segmentAngle * CGFloat(index) + angle/2
        
        if itemsCount == 2 {
            endAngle = angle * CGFloat(index)
        }
        
        let startAngle = endAngle - angle
        let midAngle = startAngle + angle/2
        
        let sector = Sector(index: index,
                            min: startAngle,
                            mid: midAngle,
                            max: endAngle)
        return sector
    }
    
    private func createSeparator(padding: CGFloat, height: CGFloat, angle: CGFloat, center: CGPoint, color: UIColor) -> UIView {
        let separator = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 1, height: height)))
        separator.backgroundColor = color
        separator.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        let separatorStartPoint = self.getPointCoordinate(withCenterIn: center,
                                                          radius: padding,
                                                          angle: angle - .pi/2)
        separator.layer.position = separatorStartPoint
        separator.transform = CGAffineTransform(rotationAngle: angle)
        return separator
    }
    
    private func createSection(in view: UIView, rotationAngle: CGFloat, model: CircleMenuItem) -> SectionView {
        let sectionRect = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: view.bounds.height/2))
        let section = SectionView(with: sectionRect, model: model, angle: 2 * .pi - rotationAngle)
        
        section.backgroundColor = .clear
        section.isHighlighted = false
        
        section.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        section.layer.position = view.center
        section.transform = CGAffineTransform(rotationAngle: rotationAngle)
        return section
    }
    
    //MARK: Private methods
    
    private func selectSegment(at index: Int) {
        if let section = self.sectors[index].section {
            self.currentSectorIndex = index
            section.isHighlighted = true
        }
    }
    
    private func deSelectSegment(at index: Int?) {
        if let thisIndex = index, let section = self.sectors[thisIndex].section {
            self.currentSectorIndex = nil
            section.isHighlighted = false
        }
    }
    
    private func detectSelectedSegment(form touchPoint: CGPoint) -> Sector? {
        // Get inverted touch angle value
        let dx = container.center.x - touchPoint.x
        let dy = container.center.y - touchPoint.y
        let angle = -atan2(dx, dy)
        
        for sector in self.sectors {
            let newAngle = angle.toPositiveRadians
            
            let min = sector.minValue.toPositiveRadians
            let max = sector.maxValue.toPositiveRadians
            
            let regularCondition = newAngle > min && newAngle < max
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
    
    private func ignoreTaps(for touchPoint: CGPoint) -> Bool {
        let dist: CGFloat = calculateDistance(fromCenter: touchPoint)
        
        if dist < self.separatorPadding || dist > self.container.bounds.width/2 {
            print("Ignoring tap \(touchPoint.x), \(touchPoint.y)")
            self.deSelectSegment(at: self.currentSectorIndex)
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
        
        view.applyMask(withPath: path, inverse: false)
    }
}
