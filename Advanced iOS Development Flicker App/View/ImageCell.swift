//
//  ImageCell.swift
//  Advanced iOS Development Flicker App
//
//  Created by Timofei Sopin on 2018-03-12.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var photoId: UILabel!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var photoLabel: UILabel!
    
    var imageSearch: ImageSearching? {
        didSet {
            if let imageSearch = imageSearch {
                imageView.sd_setImage(with: imageSearch.photoUrl as URL!)
                photoId.text = imageSearch.title
                photoLabel.text = imageSearch.photoId
            }
        }
    }
//    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//        super.apply(layoutAttributes)
//        
//        // 1
//        let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
//        let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
//
//        // 2
//        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
//
//        // 3
//        let minAlpha: CGFloat = 0.3
//        let maxAlpha: CGFloat = 0.75
//        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
//        photoIdLabel.alpha = delta
//    }
    
    
    
    
}
