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
    let playButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(play(_:)))
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
      cell.update(with: image)
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    book.removePage(at: indexPath.row)
    BooksProvider.save(books: self.allBooks)
    tableView.deleteRows(at: [indexPath], with: .automatic)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let url = book.pageAudioURL(index: indexPath.row) else {
      return
    }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback)
      player = try AVAudioPlayer(contentsOf: url)
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
    navigationController.modalPresentationStyle = .fullScreen
    present(navigationController, animated: true)
  }
  
  @objc func play(_ sender: UIBarButtonItem) {
    let next = BookPlayViewController(book: book)
    navigationController?.pushViewController(next, animated: true)
  }
}

extension BookPagesTableViewController: AVAudioPlayerDelegate {
  
}
