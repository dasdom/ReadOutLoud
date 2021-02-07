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
    let imageURL = URL(string: "imageURL")!
    let audioURL = URL(string: "audioURL")!
    book.addPageWith(index: 0, imageURL: imageURL, audioURL: audioURL)
    book.addPageWith(index: 1, imageURL: imageURL, audioURL: audioURL)
    
    sut = BookPagesTableViewController(book: book)
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
}
