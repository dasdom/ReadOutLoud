//  Created by Dominik Hauser on 05/03/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class PageStackLayout: UICollectionViewLayout {
  
  override var collectionViewContentSize: CGSize {
    
    guard let collectionView = collectionView else { return .zero }
    
    let numberOfPages = collectionView.numberOfItems(inSection: 0)
    let size = collectionView.bounds.inset(by: collectionView.safeAreaInsets).size
    return CGSize(width: CGFloat(numberOfPages) * size.width, height: size.height)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    guard let collectionView = collectionView else { return [] }
    
    var allAttributes: [UICollectionViewLayoutAttributes] = []
    
    let numberOfPages = collectionView.numberOfItems(inSection: 0)

    let previousItem = Int(max(rect.origin.x, 0) / collectionView.bounds.width)
    let previousIndexPath = IndexPath(item: previousItem, section: 0)
    
    if let previousAttribute = layoutAttributesForItem(at: previousIndexPath) {
      allAttributes.append(previousAttribute)
    }
    
    let currentItem = previousItem + 1
    if currentItem < numberOfPages {
      let currentIndexPath = IndexPath(item: currentItem, section: 0)
      
      if let currentAttribute = layoutAttributesForItem(at: currentIndexPath) {
        allAttributes.append(currentAttribute)
      }
    }
    
    let nextItem = previousItem + 2
    if nextItem < numberOfPages {
      let nextIndexPath = IndexPath(item: nextItem, section: 0)
      
      if let nextAttribute = layoutAttributesForItem(at: nextIndexPath) {
        allAttributes.append(nextAttribute)
      }
    }
        
    return allAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    
    guard let collectionView = collectionView else { return nil }

    let contentOffsetX = collectionView.contentOffset.x
//    print("contentOffsetX: \(contentOffsetX)")
    
    let size = collectionView.bounds.inset(by: collectionView.safeAreaInsets).size
    let attributes: UICollectionViewLayoutAttributes
    let minScale: CGFloat = 0.9
    if contentOffsetX <= 0 {
      attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
      if indexPath.item > 0 {
        attributes.transform = CGAffineTransform(scaleX: minScale, y: minScale)
      }
    } else if CGFloat(indexPath.item) <= contentOffsetX / collectionView.bounds.width {
      attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      let x = CGFloat(indexPath.item) * collectionView.bounds.width
      attributes.frame = CGRect(x: x, y: 0, width: size.width, height: size.height)
    } else if CGFloat(indexPath.item) - 1 <= contentOffsetX / collectionView.bounds.width {
      attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = CGRect(x: contentOffsetX, y: 0, width: size.width, height: size.height)
      let scale = max(minScale, 1 - (CGFloat(indexPath.item) * size.width - contentOffsetX) / size.width)
//      print("scale: \(scale), \(contentOffsetX)")
      attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
    } else {
      attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = .zero
    }
    
    attributes.zIndex = 100 - indexPath.item
    
//    print("attributes: \(attributes)")
    
    return attributes
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}
