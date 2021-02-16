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
    collectionView?.register(AddBookCell.self, forCellWithReuseIdentifier: AddBookCell.identifier)

    let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(settings))
    let nightButton = UIBarButtonItem(image: UIImage(named: "nightMode"), style: .plain, target: self, action: #selector(night))
    
    navigationItem.leftBarButtonItems = [settingsButton, nightButton]
    navigationItem.rightBarButtonItems = [editButtonItem]
    
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
  }
  
  // MARK: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return books.count + 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if indexPath.row >= books.count {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddBookCell.identifier, for: indexPath)
      
      return cell
      
    } else {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.identifier, for: indexPath)
      
      let book = books[indexPath.row]
      print("book.id: \(book.id)")
      if let cell = cell as? BookCellProtocol {
        cell.update(with: book)
      }
      
      return cell
    }
  }
  
  // MARK: UICollectionViewDelegate
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if indexPath.row >= books.count {
      add()
    } else {
      
      let book = books[indexPath.row]
      let next: UIViewController
      if isEditing {
        next = BookPagesTableViewController(book: book, allBooks: books, deleteCompletion: { books in
          self.books = books
          self.collectionView.reloadData()
        })
      } else {
        next = BookPlayViewController(book: book)
      }
      navigationController?.pushViewController(next, animated: true)
    }
  }
}

// MARK: - Actions
extension BooksCollectionViewController {
  @objc func add() {
    let next = BookDetailsViewController { book in
      self.books.append(book)
      self.collectionView.reloadData()
      BooksProvider.save(books: self.books)
      let next = BookPagesTableViewController(book: book, allBooks: self.books, deleteCompletion: { books in
        self.books = books
        self.collectionView.reloadData()
      })
      self.navigationController?.pushViewController(next, animated: true)
    }
    let navigationController = UINavigationController(rootViewController: next)
    present(navigationController, animated: true)
  }
    
  @objc func settings() {
    let alert = UIAlertController(title: "Access control", message: "Answer to the Ultimate Question of Life, The Universe, and Everything\n(Let blank for cancel)", preferredStyle: .alert)
    alert.addTextField()
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
      if let textField = alert.textFields?.first, textField.text == "42" || textField.text == "fourty two" {
        let next = UINavigationController(rootViewController: SettingsTableViewController())
        self.present(next, animated: true)
      }
    }))
    present(alert, animated: true)
  }
  
  @objc func night() {
    let next = NightDayViewController()
    navigationController?.pushViewController(next, animated: true)
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    if editing {
      let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
      navigationItem.rightBarButtonItems = [addButton, editButtonItem]
    } else {
      navigationItem.rightBarButtonItems = [editButtonItem]
    }
  }
}
