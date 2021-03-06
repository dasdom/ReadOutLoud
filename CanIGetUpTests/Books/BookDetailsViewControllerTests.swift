//  Created by Dominik Hauser on 06/03/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class BookDetailsViewControllerTests: XCTestCase {
  
  var sut: BookDetailsViewController!
  var bookFromCompletion: Book? = nil
  
  override func setUpWithError() throws {
    sut = BookDetailsViewController(addCompletion: { book in
      self.bookFromCompletion = book
    })
  }
  
  override func tearDownWithError() throws {
    sut = nil
    if let book = bookFromCompletion {
      FileManager.default.removeBooksDirectory(for: book)
    }
    bookFromCompletion = nil
  }
  
  func test_loadingView_addsNavigationItem() {
    sut.loadViewIfNeeded()
    
    let saveButton = sut.navigationItem.rightBarButtonItem
    
    XCTAssertNotNil(saveButton)
  }
  
  func test_save_whenTitleIsEmpty_doesntSave() throws {
    sut.loadViewIfNeeded()
    let path = Bundle(for: BookDetailsViewControllerTests.self).path(forResource: "blume", ofType: "jpg")!
    sut.contentView.coverImageView.image = UIImage(contentsOfFile: path)
    
    let saveButton = sut.navigationItem.rightBarButtonItem
    try saveButton?.performAction()
    
    XCTAssertNil(bookFromCompletion)
  }
  
  func test_save_whenImageViewIsEmpty_doesntSave() throws {
    sut.loadViewIfNeeded()
    sut.contentView.titleTextField.text = "Foo"
    
    let saveButton = sut.navigationItem.rightBarButtonItem
    try saveButton?.performAction()
    
    XCTAssertNil(bookFromCompletion)
  }
  
  func test_save_addsBook() throws {
    sut.loadViewIfNeeded()
    sut.contentView.titleTextField.text = "Foo"
    let path = Bundle(for: BookDetailsViewControllerTests.self).path(forResource: "blume", ofType: "jpg")!
    sut.contentView.coverImageView.image = UIImage(contentsOfFile: path)
    
    let saveButton = sut.navigationItem.rightBarButtonItem
    try saveButton?.performAction()
    
    let book = try XCTUnwrap(bookFromCompletion)
    let coverURL = FileManager.default.bookCoverURL(for: book)
    let coverExists = FileManager.default.fileExists(atPath: coverURL.path)
    XCTAssertEqual(coverExists, true)
  }
}
