//  Created by dasdom on 29.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

class BooksCollectionViewController: UICollectionViewController {
  
  var books: [Book]
  
  init() {
    let flowLayout = UICollectionViewFlowLayout()
    
    books = BooksProvider.loadBooks()
    
    super.init(collectionViewLayout: flowLayout)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.register(BookCell.self, forCellWithReuseIdentifier: BookCell.identifier)
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
    navigationItem.rightBarButtonItem = addButton
        
    title = "Books"
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
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.identifier, for: indexPath)
    
    let book = books[indexPath.row]
    if let cell = cell as? BookCellProtocol {
      cell.update(with: book)
    }
    
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let book = books[indexPath.row]
    let next = BookPagesTableViewController(book: book)
    navigationController?.pushViewController(next, animated: true)
  }
}

// MARK: - Actions
extension BooksCollectionViewController {
  @objc func add(_ sender: UIBarButtonItem) {
    let next = BookDetailsViewController { book in
      self.books.append(book)
      self.collectionView.reloadData()
      BooksProvider.save(books: self.books)
    }
    let navigationController = UINavigationController(rootViewController: next)
    present(navigationController, animated: true)
  }
}
