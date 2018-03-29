//
//  EPZoomCell.swift
//  EPCardZoomLayout-Example
//
//  Created by Evgeniy on 29.03.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

final class EPZoomCell: UICollectionViewCell {
    // MARK: - Outlets
    
    @IBOutlet var distanceLabel: UILabel!
    
    @IBOutlet var indexLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Setters
    
    var distance: CGFloat = -1 { didSet { distanceLabel.text = "\(distance.rounded())" } }
    
    var index: Int = -1 { didSet { indexLabel.text = "Index: \(index)" } }
    
    var color: UIColor? { didSet { imageView.backgroundColor = color } }
}
