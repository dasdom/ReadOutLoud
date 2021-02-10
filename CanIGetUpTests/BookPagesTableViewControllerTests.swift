//  Created by dasdom on 31.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class BookPagesTableViewControllerTests: XCTestCase {
  
  var sut: BookPagesTableViewController!
  private var book: Book!
  
  override func setUpWithError() throws {
    book = Book(title: "Foo", author: "Bar")
    book.add(Page(index: 0))
    book.add(Page(index: 1))
    
    sut = BookPagesTableViewController(book: book, allBooks: [book])
  }
  
  override func tearDownWithError() throws {
    sut = nil
    book = nil
  }
  
  func test_title_isBookTitle() {
    sut.loadViewIfNeeded()
    
    XCTAssertEqual(sut.title, "Foo")
  }
  
  func test_registers_pageCell() {
    sut.loadViewIfNeeded()
    
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: PageCell.identifier, for: indexPath)
    
    XCTAssertTrue(cell is PageCell)
  }
  
  func test_numberOfRows_isNumberOfPages() {
    
    let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
    
    XCTAssertEqual(numberOfRows, book.pageCount)
  }
  
  func test_cellForRow_returnsPageCell() {
    
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
    
    XCTAssertTrue(cell is PageCell)
  }
  
  func test_cellForRow_callsUpdate() {
    
    sut.tableView.register(MockPageCell.self, forCellReuseIdentifier: PageCell.identifier)
    
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath) as! MockPageCell
    
    XCTAssertNotNil(cell.lastImageFromUpdate)
  }
}
