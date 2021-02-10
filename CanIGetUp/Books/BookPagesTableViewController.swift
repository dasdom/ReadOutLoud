//  Created by dasdom on 29.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit
import AVFoundation

class BookPagesTableViewController: UITableViewController {
  
  var book: Book
  var allBooks: [Book]
  private var player: AVAudioPlayer?

  init(book: Book, allBooks: [Book]) {
    
    self.book = book
    self.allBooks = allBooks
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
    navigationItem.rightBarButtonItem = addButton
    
    tableView.register(PageCell.self, forCellReuseIdentifier: PageCell.identifier)
    
    title = book.title
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return book.pageCount
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: PageCell.identifier, for: indexPath)
    
    if let image = UIImage(contentsOfFile: book.pageImageURL(index: indexPath.row).path), let cell = cell as? PageCellProtocol {
      cell.update(with: image)
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback)
      player = try AVAudioPlayer(contentsOf: book.pageAudioURL(index: indexPath.row))
      player?.delegate = self
      player?.play()
    } catch {
      print("error: \(error)")
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
}

// MARK: - Actions
extension BookPagesTableViewController {
  @objc func add(_ sender: UIBarButtonItem) {
    let next = BookPageInputViewController(book: book, completion: {
      self.tableView.reloadData()
      BooksProvider.save(books: self.allBooks)
    })
    let navigationController = UINavigationController(rootViewController: next)
    present(navigationController, animated: true)
  }
}

extension BookPagesTableViewController: AVAudioPlayerDelegate {
  
}
