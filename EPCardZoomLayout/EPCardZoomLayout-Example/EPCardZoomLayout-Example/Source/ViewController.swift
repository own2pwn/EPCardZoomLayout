//
//  ViewController.swift
//  EPCardZoomLayout-Example
//
//  Created by Evgeniy on 29.03.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import EPCardZoomLayout
import UIKit

final class ViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet var collectionView: UICollectionView!

    @IBOutlet var scrollingStatusLabel: UILabel!

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreen()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        ic.scrollToCenter(animated: false)
        ic.scrollCoordinator.updateContainerCenter(collectionView.center)
    }

    // MARK: - Members

    private var shouldScroll = true

    private let colors: [UIColor] = [#colorLiteral(red: 0.7825108767, green: 0.3639084697, blue: 0.4368497729, alpha: 1), #colorLiteral(red: 1, green: 0.667937696, blue: 0.4736554623, alpha: 1), #colorLiteral(red: 0.07389535755, green: 0.4140536785, blue: 0.7077813148, alpha: 1), #colorLiteral(red: 0.2040559649, green: 0.7372421622, blue: 0.6007294059, alpha: 1)]

    private let ic = EPInfiniteScrollController<EPDisplayModel>()

    // MARK: - Methods

    private func setupScreen() {
        setupInfiniteScrolling()
        fetchModel()
        updateScrollingStatus()
    }

    private func setupInfiniteScrolling() {
        ic.setCollectionView(collectionView)

        ic.animator.setMinScale(CUI.Item.cellScale)
        ic.scrollCoordinator.setLayout(cellSize: CUI.Item.cellSize, cellSpacing: CUI.Item.cellSpacing)
    }

    private func fetchModel() {
        let fetched = colors.indices.map { EPDisplayModel(color: colors[$0], index: $0 + 1) }
        ic.dataProvider.update(with: fetched)
    }

    // MARK: - Actions

    private func updateScrollingStatus() {
        scrollingStatusLabel.text = "Scrolling: \(shouldScroll)"
    }

    @IBAction func didTapToggleButton(_ sender: UIButton) {
        shouldScroll.toggle()
        updateScrollingStatus()
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells = collectionView.visibleCells
        ic.animator.transform(visibleCells)

        guard shouldScroll else { return }
        ic.scrollCoordinator.onScroll(scrollView)
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return ic.dataProvider.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EPZoomCell = collectionView.dequeueReusableCell(at: indexPath)
        let item = ic.dataProvider.item(at: indexPath)

        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.color = item.color
        cell.index = item.index

        let dist = (CUI.Item.cellSize.width + CUI.Item.cellSpacing) * CGFloat(indexPath.row)
        cell.distance = dist

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        ic.animator.transform(cell)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { return CUI.Item.cellSize }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return CUI.Item.cellSpacing }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return CUI.Item.cellSpacing }
}
