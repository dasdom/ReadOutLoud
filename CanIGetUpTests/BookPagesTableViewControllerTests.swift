//  Created by dasdom on 31.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class BookPagesTableViewControllerTests: XCTestCase {
  
  var sut: BookPagesTableViewController!
  
  override func setUpWithError() throws {
    let book = Book(title: "Foo", author: "Bar")
    sut = BookPagesTableViewController(book: book)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_registers_pageCell() {
    sut.loadViewIfNeeded()
    
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: PageCell.identifier, for: indexPath)
    
    XCTAssertTrue(cell is PageCell)
  }
}
