//  Created by dasdom on 10.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class BooksCollectionViewControllerTests: XCTestCase {
  
  var sut: BooksCollectionViewController!
  var mockBooksProvider: MockBooksProvider!
  
  override func setUpWithError() throws {
    sut = BooksCollectionViewController()
    mockBooksProvider = MockBooksProvider(bookTitles: ["Foo"])
    sut.booksProvider = mockBooksProvider
    sut.beginAppearanceTransition(true, animated: false)
    sut.endAppearanceTransition()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    mockBooksProvider = nil
  }
 
  func test_numberOfCells_whenOnBookIsAdded() {
    
    XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 1)
  }
  
  func test_numberOfCells_whenThreeBooksAreAdded() {
    mockBooksProvider.bookTitles = ["Foo", "Bar", "Baz"]
    sut.beginAppearanceTransition(true, animated: false)
    sut.endAppearanceTransition()
    
    XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 3)
  }
  
  func test_cellForRow_returnsBookCell() {
    
    let indexPath = IndexPath(item: 0, section: 0)
    let cell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: indexPath)
    
    XCTAssertTrue(cell is BookCell)
  }
  
  func test_cellForRow_callsUpdate() {
    sut.collectionView.register(MockBookCell.self, forCellWithReuseIdentifier: BookCell.identifier)
    
    let indexPath = IndexPath(item: 0, section: 0)
    let cell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: indexPath) as! MockBookCell
    
    XCTAssertEqual(cell.updateCallCount, 1)
  }
  
  func test_selectItem_pushesPagesViewController() {
    let mockNavigationController = MockNavigationController(rootViewController: sut)
    
    let indexPath = IndexPath(item: 0, section: 0)
    sut.collectionView.delegate?.collectionView?(sut.collectionView, didSelectItemAt: indexPath)
    
    XCTAssertTrue(mockNavigationController.pushedViewController is BookPlayViewController)
  }
}
