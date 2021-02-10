//  Created by Dom on 06.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class BookTests: XCTestCase {
  
  override func setUpWithError() throws {
  }
  
  override func tearDownWithError() throws {
  }
  
  func test_addPage_addsPage() {
    let sut = Book(title: "Foo", author: "Bar")
    
    let page = Page(index: 0)
    sut.add(page)
    
    XCTAssertEqual(sut.pageCount, 1)
  }
  
  func test_addTwoPages_addsTwoPages() {
    let sut = Book(title: "Foo", author: "Bar")
    
    let page1 = Page(index: 0)
    sut.add(page1)
    let page2 = Page(index: 1)
    sut.add(page2)
    
    XCTAssertEqual(sut.pageCount, 2)
  }
}

extension BookTests {
  func imageURL() -> URL {
    return URL(string: "imageURL")!
  }
  
  func audioURL() -> URL {
    return URL(string: "audioURL")!
  }
}
