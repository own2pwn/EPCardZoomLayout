//
//  EPInfiniteScrollAnimator.swift
//  EPCardZoomLayout
//
//  Created by Evgeniy on 28.03.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public final class EPInfiniteScrollAnimator {
    // MARK: - Members
    
    public private(set) var collectionView: UICollectionView!
    
    public private(set) var minScale: CGFloat
    
    public private(set) var cachedCenter: CGPoint
    
    // MARK: - Interface
    
    public func transform(_ cell: UICollectionViewCell) {
        let position = cell.center - collectionView.contentOffset // in container
        let centerDst = position.distance(to: cachedCenter)
        
        let scale = 1 - (centerDst / scaleFactor)
        
        cell.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
    }
    
    public func transform(_ cells: [UICollectionViewCell]) {
        cells.forEach { transform($0) }
    }
    
    // MARK: - Setters
    
    public func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        invalidateCache()
        updateScaleFactor()
    }
    
    public func setMinScale(_ scale: CGFloat) {
        minScale = scale
        updateScaleFactor()
    }
    
    public func invalidateCache() {
        cachedCenter = collectionView.bounds.center
    }
    
    // MARK: - Internal
    
    private var scaleFactor: CGFloat = 1
    
    // MARK: - Init
    
    public init() {
        minScale = 1
        cachedCenter = .zero
    }
    
    public init(with collectionView: UICollectionView, and minScale: CGFloat) {
        self.collectionView = collectionView
        self.minScale = minScale
        cachedCenter = .zero
        
        updateScaleFactor()
    }
    
    // MARK: - Helpers
    
    private func updateScaleFactor() {
        let d = collectionView.frame.center
        let factor = -d / (minScale - 1)
        
        scaleFactor = factor.x
    }
}
