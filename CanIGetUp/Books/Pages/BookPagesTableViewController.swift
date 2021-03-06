//  Created by dasdom on 29.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit
import AVFoundation

class BookPagesTableViewController: UITableViewController {
  
  var book: Book
  var allBooks: [Book]
  lazy var booksProvider: BooksProvider = BooksProvider()
  private let deleteCompletion: ([Book]) -> Void
  private var formatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = .pad
    return formatter
  }()

  init(book: Book, allBooks: [Book], deleteCompletion: @escaping ([Book]) -> Void) {
    
    self.book = book
    self.allBooks = allBooks
    self.deleteCompletion = deleteCompletion
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
    let playButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trash(_:)))
    navigationItem.rightBarButtonItems = [addButton, playButton]
    
    tableView.register(PageTableViewCell.self, forCellReuseIdentifier: PageTableViewCell.identifier)
    
    title = book.title
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return book.pageCount
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: PageTableViewCell.identifier, for: indexPath)
    
    if let url = book.pageImageURL(index: indexPath.row),
       let image = UIImage(contentsOfFile: url.path),
       let cell = cell as? PageTableViewCellProtocol {
      
      let durationString: String
      if let duration = book.pageForIndex(indexPath.row)?.duration {
        durationString = formatter.string(from: duration) ?? ""
      } else {
        durationString = ""
      }
      cell.update(with: image, durationString: durationString)
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    book.removePage(at: indexPath.row)
    booksProvider.save(books: self.allBooks)
    tableView.deleteRows(at: [indexPath], with: .automatic)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let page = book.pageForIndex(indexPath.row)
    let next = BookPageInputViewController(book: book, page: page, completion: { [weak self] in
      
      guard let self = self else { return }
      
      self.tableView.reloadData()
      self.booksProvider.save(books: self.allBooks)
    })
    
    next.modalPresentationStyle = .fullScreen
    present(next, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}

// MARK: - Actions
extension BookPagesTableViewController {
  @objc func add(_ sender: UIBarButtonItem) {
    let next = BookPageInputViewController(book: book, completion: { [weak self] in
      
      guard let self = self else { return }
      
      self.tableView.reloadData()
      self.booksProvider.save(books: self.allBooks)
    })
    next.modalPresentationStyle = .fullScreen
    present(next, animated: true)
  }
  
//  @objc func play(_ sender: UIBarButtonItem) {
//    let next = BookPlayViewController(book: book)
//    navigationController?.pushViewController(next, animated: true)
//  }
  
  @objc func trash(_ sender: UIBarButtonItem) {
    
    let title = NSLocalizedString("Remove book", comment: "")
    let message = NSLocalizedString("Do you really want to delete this book? Deletion cannot be reversed.", comment: "")
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let removeTitle = NSLocalizedString("Remove", comment: "")
    alert.addAction(UIAlertAction(title: removeTitle, style: .default, handler: { action in
      FileManager.default.removeBooksDirectory(for: self.book)
      self.allBooks.removeAll(where: { $0.id == self.book.id })
      self.booksProvider.save(books: self.allBooks)
      self.deleteCompletion(self.allBooks)
      self.navigationController?.popViewController(animated: true)
    }))
    
    let cancelTitle = NSLocalizedString("Cancel", comment: "")
    alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
    
    present(alert, animated: true)
  }
}

extension BookPagesTableViewController: AVAudioPlayerDelegate {
  
}
