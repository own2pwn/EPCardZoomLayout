//
//  EPInfiniteDataProvider.swift
//  EPCardZoomLayout
//
//  Created by Evgeniy on 28.03.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation

public protocol EPInfiniteDataProviderUpdateDelegate: class {
    
    /// Receives original count of the datasource items
    ///
    /// called after init with non empty datsource, too
    func didUpdate(with count: Int)
}

public final class EPInfiniteDataProvider<Item> {
    // MARK: - Interface
    
    /// The number of elements for the datasource.
    public var count: Int { return fakeCount }
    
    /// The number of elements in the original collection.
    public private(set) var originalCount: Int
    
    /// Delegate that reacts to the datasource updates
    public weak var updateDelegate: EPInfiniteDataProviderUpdateDelegate?
    
    // MARK: - Getters
    
    public func item(at indexPath: IndexPath) -> Item { return provider(indexPath.row) }
    
    public func item(at index: Int) -> Item { return provider(index) }
    
    // MARK: - Setters
    
    /// Updates the internal datasource with then new data.
    public func update(with model: [Item]) {
        datasource = model
        originalCount = model.count
        chooseIndexMappingStrategy()
        
        updateDelegate?.didUpdate(with: originalCount)
    }
    
    // MARK: - Internal
    
    private typealias IndexMapper = (Int) -> Item
    
    /// Internal data source
    private var datasource: [Item]
    
    /// Used for the display datasource to allow it
    /// calculate it's content size.
    private var fakeCount: Int = 0
    
    /// Returns the element
    /// using the chosen `Index Mapping Strategy`.
    private var provider: IndexMapper!
    
    // MARK: - Init
    
    public init() {
        datasource = []
        originalCount = 0
    }
    
    public init(with items: [Item]) {
        datasource = items
        originalCount = items.count
        
        updateDelegate?.didUpdate(with: originalCount)
    }
    
    // MARK: - Mapping
    
    private func chooseIndexMappingStrategy() {
        let strategy = originalCount > 2 ? baseMapping : miniMapping
        strategy()
    }
    
    private func miniMapping() {
        fakeCount = 6
        provider = miniProvider
    }
    
    private func baseMapping() {
        let overhead = 4
        fakeCount = originalCount + overhead
        provider = baseProvider
    }
    
    // MARK: - Data Provider
    
    private func miniProvider(_ index: Int) -> Item {
        let normalizedIdx = index % originalCount
        
        return datasource[normalizedIdx]
    }
    
    private func baseProvider(_ index: Int) -> Item {
        let idx = index < 2 ? originalCount + index
            : index > originalCount + 1 ? index - originalCount
            : index
        
        let normalizedIdx = idx - 2
        
        return datasource[normalizedIdx]
    }
}
