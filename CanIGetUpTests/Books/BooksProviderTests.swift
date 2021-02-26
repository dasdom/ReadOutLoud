//  Created by Dom on 06.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class BooksProviderTests: XCTestCase {

  private var book: Book!
  
  override func setUpWithError() throws {
    book = Book(title: "Foo")
    FileManager.default.createBooksDiretory(for: book)
  }
  
  override func tearDownWithError() throws {
    FileManager.default.removeBooksDirectory(for: book)
  }

  func test_save_returnsPage() {
    
    let page = BooksProvider().save(imageData: Data(), audioData: Data(), duration: 20, inBook: book)
    
    XCTAssertNotNil(page)
  }
}
