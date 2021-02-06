//  Created by dasdom on 10.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class BooksCollectionViewControllerTests: XCTestCase {
  
  var sut: BooksCollectionViewController!
  
  override func setUpWithError() throws {
    sut = BooksCollectionViewController()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
 
  func test_numberOfCells_whenOnBookIsAdded() {
    sut.books = [Book(title: "Foo", author: "Bar")]
    
    XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 1)
  }
  
  func test_numberOfCells_whenThreeBooksAreAdded() {
    sut.books = [Book(title: "Foo", author: "Bar"),
                 Book(title: "Foo1", author: "Bar"),
                 Book(title: "Foo2", author: "Bar")]
    
    XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 3)
  }
  
  func test_cellForRow_returnsBookCell() {
    sut.books = [Book(title: "Foo", author: "Bar")]
    
    let indexPath = IndexPath(item: 0, section: 0)
    let cell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: indexPath)
    
    XCTAssertTrue(cell is BookCell)
  }
  
  func test_cellForRow_callsUpdate() {
    sut.books = [Book(title: "Foo", author: "Bar")]
    sut.collectionView.register(MockBookCell.self, forCellWithReuseIdentifier: BookCell.identifier)
    
    let indexPath = IndexPath(item: 0, section: 0)
    let cell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: indexPath) as! MockBookCell
    
    XCTAssertEqual(cell.updateCallCount, 1)
  }
  
  func test_selectItem_pushesPagesViewController() {
    let mockNavigationController = MockNavigationController(rootViewController: sut)
    sut.books = [Book(title: "Foo", author: "Bar")]

    let indexPath = IndexPath(item: 0, section: 0)
    sut.collectionView.delegate?.collectionView?(sut.collectionView, didSelectItemAt: indexPath)
    
    XCTAssertTrue(mockNavigationController.pushedViewController is BookPagesTableViewController)
  }
}
