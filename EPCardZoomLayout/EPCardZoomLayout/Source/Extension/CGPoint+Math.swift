//
//  CGPoint+Math.swift
//  EPCardZoomLayout
//
//  Created by Evgeniy on 29.03.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import CoreGraphics

extension CGPoint {

    static func - (left: CGPoint, right: CGPoint) -> CGPoint { return CGPoint(x: left.x - right.x, y: left.y - right.y) }

    static prefix func - (point: CGPoint) -> CGPoint { return CGPoint.zero - point }

    static func / (left: CGPoint, right: CGFloat) -> CGPoint { return CGPoint(x: left.x / right, y: left.y / right) }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat { return sqrt(pow(self.x - point.x, 2) + pow(self.y - point.y, 2)) }
}
