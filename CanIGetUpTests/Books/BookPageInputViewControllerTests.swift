//  Created by Dominik Hauser on 12/03/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class BookPageInputViewControllerTests: XCTestCase {
  
  var sut: BookPageInputViewController!
  
  override func setUpWithError() throws {
    let book = MockBook(title: "Foo")
    sut = BookPageInputViewController(book: book, completion: {})
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_initWithoutPage_whenLoaded_showsNextButton() throws {
    
    sut.loadViewIfNeeded()
    
    let view = try XCTUnwrap(sut.view as? BookPageInputView)
    XCTAssertEqual(view.nextButton.isHidden, false)
  }
  
  func test_initWithPage_whenLoaded_hidesNextButton() throws {
    let book = MockBook(title: "Foo")
    let page = Page()
    let sut = BookPageInputViewController(book: book, page: page, completion: {})
    
    sut.loadViewIfNeeded()
    
    let view = try XCTUnwrap(sut.view as? BookPageInputView)
    XCTAssertEqual(view.nextButton.isHidden, true)
  }
  
  func test_imageInputButton_showsImagePicker() throws {
    let book = MockBook(title: "Foo")
    let sut = SpyBookPageInputViewController(book: book, completion: {})
    sut.loadViewIfNeeded()
    let pageInputView = try XCTUnwrap(sut.view as? BookPageInputView)
    
    pageInputView.imageInputButton.sendActions(for: .touchUpInside)
    
    XCTAssertTrue(sut.lastPresented is UIImagePickerController)
  }
}
