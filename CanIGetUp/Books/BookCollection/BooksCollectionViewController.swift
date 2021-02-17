//  Created by dasdom on 29.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

class BooksCollectionViewController: UICollectionViewController {
  
  var books: [Book] = []
  var booksToShow: [Book] = []
  
  init() {
    let flowLayout = UICollectionViewFlowLayout()
        
    super.init(collectionViewLayout: flowLayout)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.register(BookCell.self, forCellWithReuseIdentifier: BookCell.identifier)
    collectionView?.register(AddBookCell.self, forCellWithReuseIdentifier: AddBookCell.identifier)

    title = "Books"
    
    collectionView.backgroundColor = .white
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      let itemWidth = collectionView.frame.size.width / 2 - 5
      let itemHeight = itemWidth
      flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(settings))
    let nightButton = UIBarButtonItem(image: UIImage(named: "nightMode"), style: .plain, target: self, action: #selector(night))
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    
    books = BooksProvider.loadBooks()

    if isEditing {
      navigationItem.rightBarButtonItem = addButton
      booksToShow = books
    } else {
      navigationItem.leftBarButtonItem = nightButton
      navigationItem.rightBarButtonItem = settingsButton
      booksToShow = books.filter({ $0.pageCount > 0 })
    }
    
    collectionView.reloadData()
  }
  
  // MARK: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return booksToShow.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.identifier, for: indexPath)
    
    let book = booksToShow[indexPath.row]
    print("book.id: \(book.id)")
    if let cell = cell as? BookCellProtocol {
      cell.update(with: book)
    }
    
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let book = booksToShow[indexPath.row]
    let next: UIViewController
    if isEditing {
      next = BookPagesTableViewController(book: book, allBooks: booksToShow, deleteCompletion: { books in
        self.booksToShow = books
        self.collectionView.reloadData()
      })
    } else {
      next = BookPlayViewController(book: book)
    }
    navigationController?.pushViewController(next, animated: true)
  }
}

// MARK: - Actions
extension BooksCollectionViewController {
  @objc func add() {
    let next = BookDetailsViewController { book in
      self.booksToShow.append(book)
      self.collectionView.reloadData()
      BooksProvider.save(books: self.booksToShow)
      let next = BookPagesTableViewController(book: book, allBooks: self.booksToShow, deleteCompletion: { books in
        self.booksToShow = books
        self.collectionView.reloadData()
      })
      self.navigationController?.pushViewController(next, animated: true)
    }
    let navigationController = UINavigationController(rootViewController: next)
    navigationController.modalPresentationStyle = .fullScreen
    present(navigationController, animated: true)
  }
    
  @objc func settings() {
    let alert = UIAlertController(title: "Access control", message: "Answer to the Ultimate Question of Life, The Universe, and Everything\n(Let blank for cancel)", preferredStyle: .alert)
    alert.addTextField()
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
      if let textField = alert.textFields?.first, textField.text == "42" || textField.text == "fourty two" {
        let next = UINavigationController(rootViewController: SettingsTableViewController())
        next.modalPresentationStyle = .fullScreen
        self.present(next, animated: true)
      }
    }))
    present(alert, animated: true)
  }
  
  @objc func night() {
    let next = NightDayViewController()
    navigationController?.pushViewController(next, animated: true)
  }
  
//  override func setEditing(_ editing: Bool, animated: Bool) {
//    super.setEditing(editing, animated: animated)
//    if editing {
//      let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
//      navigationItem.rightBarButtonItems = [addButton, editButtonItem]
//    } else {
//      navigationItem.rightBarButtonItems = [editButtonItem]
//    }
//  }
}
