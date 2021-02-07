//  Created by Dom on 06.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class BooksProviderTests: XCTestCase {

  override func setUpWithError() throws {
    
  }
  
  override func tearDownWithError() throws {
    
  }

  func test_save_returnsPage() {
    let book = Book(title: "Foo", author: "Bar")
    // This test is failing because we haven't implemented this API yet.
    let page = BooksProvider.save(imageData: Data(), audioData: Data(), inBook: book, forPageIndex: 42)
    
    XCTAssertEqual(page.index, 42)
  }
}
