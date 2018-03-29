//
//  EPInfiniteController.swift
//  EPCardZoomLayout
//
//  Created by Evgeniy on 28.03.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public final class EPInfiniteController<Item> {
    // MARK: - Interface
    
    public var dataProvider: EPInfiniteDataProvider<Item>
    
    public var scrollCoordinator: EPInfiniteScrollCoordinator
    
    public var animator: EPInfiniteScrollAnimator
    
    // MARK: - Setters
    
    public func setDataProvider(_ provider: EPInfiniteDataProvider<Item>) {
        dataProvider = provider
    }
    
    public func setScrollCoordinator(_ coordinator: EPInfiniteScrollCoordinator) {
        scrollCoordinator = coordinator
    }
    
    public func setDatasourceUpdateDelegate(_ delegate: EPInfiniteDataProviderUpdateDelegate) {
        dataProvider.updateDelegate = delegate
    }
    
    public func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        scrollCoordinator.setCollectionView(collectionView)
        animator.setCollectionView(collectionView)
    }
    
    public func scrollToCenter(animated: Bool) {
        collectionView.scrollToItem(at: scrollCoordinator.centerIndexPath, at: .centeredHorizontally, animated: animated)
    }
    
    // MARK: - Internal
    
    private var collectionView: UICollectionView!
    
    // MARK: - Init
    
    /// Convenience init
    public convenience init() {
        let dataProvider = EPInfiniteDataProvider<Item>()
        let scrollCoordinator = EPInfiniteScrollCoordinator()
        let animator = EPInfiniteScrollAnimator()
        
        self.init(with: dataProvider, and: scrollCoordinator, and: animator)
    }
    
    public init(with dataProvider: EPInfiniteDataProvider<Item>, and scrollCoordinator: EPInfiniteScrollCoordinator, and animator: EPInfiniteScrollAnimator) {
        self.dataProvider = dataProvider
        self.scrollCoordinator = scrollCoordinator
        self.animator = animator
        
        dataProvider.updateDelegate = scrollCoordinator
    }
    
    public init(with dataProvider: EPInfiniteDataProvider<Item>, and scrollCoordinator: EPInfiniteScrollCoordinator,
                and animator: EPInfiniteScrollAnimator, and collectionView: UICollectionView) {
        self.dataProvider = dataProvider
        self.scrollCoordinator = scrollCoordinator
        self.animator = animator
        self.collectionView = collectionView
        
        dataProvider.updateDelegate = scrollCoordinator
    }
}
