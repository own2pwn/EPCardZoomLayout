//
//  CGRect+Instance.swift
//  EPCardZoomLayout
//
//  Created by Evgeniy on 29.03.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import CoreGraphics

extension CGRect {
    var center: CGPoint { return CGPoint(x: midX, y: midY) }
}
