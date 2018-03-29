EPCardZoomLayout


![Demo1](https://media.giphy.com/media/5bo9iahfS1jm7lGxbc/giphy.gif)
![Demo2](https://media.giphy.com/media/1d5WN65apdW8No8QS0/giphy.gif)

Setup

1. Instantiate EPInfiniteController of your `ModelType`

```swift
private let ic = EPInfiniteController<YourModel>()
```
2. Setup Infinite Behaviour

```swift
private func setupInfiniteScrolling() {
        // `collectionView` and `layout` Will be used to
        // Calculate Scroll Points
        
        ic.setCollectionView(collectionView)
        ic.scrollCoordinator.setLayout(cellSize: CUI.Item.cellSize, cellSpacing: CUI.Item.cellSpacing)
        
        // Will be used for animation
        ic.animator.setMinScale(CUI.Item.cellScale)
    }
```

3. Update InfiniteController's datasource

```swift
private func fetchModel() {
        let fetched = YourModel()
        ic.dataProvider.update(with: fetched)
    }
```

4. Update container's center after view ended layout

```swift
override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // To appear nicely
        ic.scrollToCenter(animated: false)
        
        // To recalculate scroll points
        ic.scrollCoordinator.updateContainerCenter(collectionView.center)
    }
```

5. Coordinate scrolling and animations

```swift
 func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells = collectionView.visibleCells
        ic.animator.transform(visibleCells)
        ic.scrollCoordinator.onScroll(scrollView)
    }
```

6. You're good to go!