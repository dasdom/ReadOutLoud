//  Created by dasdom on 29.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

class BooksCollectionViewController: UICollectionViewController {
  
  var books: [Book] = []
  
  init() {
    let flowLayout = UICollectionViewFlowLayout()
    super.init(collectionViewLayout: flowLayout)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.register(BookCell.self, forCellWithReuseIdentifier: BookCell.identifier)
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
    navigationItem.rightBarButtonItem = addButton
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      let itemWidth = collectionView.frame.size.width / 2 - 20
      let itemHeight = itemWidth
      flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
  }
  
  // MARK: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return books.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.identifier, for: indexPath) as? BookCell else {
      return UICollectionViewCell()
    }
    
    let book = books[indexPath.row]
    cell.update(with: book)
    
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  
  /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment this method to specify if the specified item should be selected
   override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
   override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
   
   }
   */
}

// MARK: - Actions
extension BooksCollectionViewController {
  @objc func add(_ sender: UIBarButtonItem) {
    let next = BookDetailsViewController()
    let navigationController = UINavigationController(rootViewController: next)
    present(navigationController, animated: true)
  }
}
