//  Created by dasdom on 29.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

class BookPagesTableViewController: UITableViewController {
  
  var book: Book
  
  init(book: Book) {
    
    self.book = book
    
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
    
    return cell
  }
}

// MARK: - Actions
extension BookPagesTableViewController {
  @objc func add(_ sender: UIBarButtonItem) {
    let next = BookPageInputViewController(book: book)
    let navigationController = UINavigationController(rootViewController: next)
    present(navigationController, animated: true)
  }
}
