//
//  EPInfiniteScrollCoordinator.swift
//  EPCardZoomLayout
//
//  Created by Evgeniy on 28.03.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public final class EPInfiniteScrollCoordinator {
    // MARK: - Interface
    
    public let centerIndexPath = IndexPath(row: 2, section: 0)
    
    public func onScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        
        if offsetX <= leftThreshold {
            let dist = leftThreshold - offsetX
            let rightPosition = rightScrollPosition - dist
            
            scroll(to: rightPosition, scrollView)
        }
        else if offsetX >= rightThreshold {
            let dist = offsetX - rightThreshold
            let leftPosition = leftScrollPosition + dist
            
            scroll(to: leftPosition, scrollView)
        }
    }
    
    // MARK: - Setters
    
    public func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    public func setLayout(cellSize: CGSize, cellSpacing: CGFloat) {
        self.cellSize = cellSize
        self.cellSpacing = cellSpacing
        
        updateLayout()
    }
    
    public func updateContainerCenter(_ center: CGPoint) {
        containerCenterX = center.x
        updateLayout()
    }
    
    // MARK: - Internal
    
    private var collectionView: UICollectionView!
    
    private var count: Int = 0
    
    // MARK: - Scroll strategy
    
    /// Index of the cell
    /// that would be used
    /// to calculate the `leftThreshold`.
    private let leftStartIdx = 1
    
    /// Index of the cell
    /// that would be used
    /// to calculate the `rightScrollPosition`.
    private var leftTargetIdx = 0
    
    /// Index of the cell
    /// that would be used
    /// to calculate the `rightThreshold`.
    private var rightStartIdx = 0
    
    /// Index of the cell
    /// that would be used
    /// to calculate the `leftScrollPosition`.
    private let rightTargetIdx = 2
    
    // MARK: Scroll positions
    
    /// If the `contentOffset` <= this value
    /// then scroll to the `rightScrollPosition`
    /// would be performed.
    private var leftThreshold: CGFloat = 0
    
    /// Point(x) to scroll to from the left threshold.
    private var rightScrollPosition: CGFloat = 0
    
    /// If the `contentOffset` >= this value
    /// then scroll to the `leftScrollPosition`
    /// would be performed.
    private var rightThreshold: CGFloat = 0
    
    /// Point(x) to scroll to from the right threshold.
    private var leftScrollPosition: CGFloat = 0
    
    // MARK: Layout
    
    private var cellSize: CGSize = .zero
    
    private var containerCenterX: CGFloat = 0
    
    private var cellSpacing: CGFloat = 0
    
    // MARK: - Init
    
    public init() {}
    
    // MARK: Layout
    
    private func updateLayout() {
        chooseScrollStrategy()
        updateScrollPoints()
    }
    
    // MARK: - Scrolling
    
    private func chooseScrollStrategy() {
        let strategy = count > 2 ? baseScrolling : miniScrolling
        strategy()
    }
    
    private func miniScrolling() {
        leftTargetIdx = 3
        rightStartIdx = 4
    }
    
    private func baseScrolling() {
        leftTargetIdx = leftStartIdx + count
        rightStartIdx = 2 + count
    }
    
    // MARK: - Helpers
    
    private func updateScrollPoints() {
        leftThreshold = cellCenter(at: leftStartIdx).x
        rightScrollPosition = cellCenter(at: leftTargetIdx).x
        
        rightThreshold = cellCenter(at: rightStartIdx).x
        leftScrollPosition = cellCenter(at: rightTargetIdx).x
    }
    
    /// We assume that idx is at least `1`.
    private func cellCenter(at idx: Int) -> CGPoint {
        let cellWidth = cellSize.width
        let containerCenter = containerCenterX
        let idx = CGFloat(idx)
        
        let a = CGFloat(idx + 1) * (cellWidth + cellSpacing) - containerCenter
        let b = a - cellWidth / 2
        let result = b - cellSpacing
        
        return CGPoint(x: result, y: 0)
    }
    
    @inline(__always)
    private func scroll(to position: CGFloat, _ scrollView: UIScrollView) {
        let scrollPoint = CGPoint(x: position, y: 0)
        
        scrollView.setContentOffset(scrollPoint, animated: false)
    }
}

extension EPInfiniteScrollCoordinator: EPInfiniteDataProviderUpdateDelegate {
    public func didUpdate(with count: Int) {
        self.count = count
        updateLayout()
    }
}
