//
//  Cell+Reuse.swift
//  EPCardZoomLayout
//
//  Created by Evgeniy on 01.03.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var reuseID: String { get }
}

extension Reusable {
    static var reuseID: String { return String(describing: self) }
}

extension UITableViewCell: Reusable {}

extension UICollectionViewCell: Reusable {}

extension UIViewController: Reusable {}

extension UICollectionView {
    func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as! T

        return cell
    }
}
