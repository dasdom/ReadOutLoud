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
    
    sut.addPageWith(index: 0, imageURL: imageURL(), audioURL: audioURL())
    
    XCTAssertEqual(sut.pageCount, 1)
  }
  
  func test_addTwoPages_addsTwoPages() {
    let sut = Book(title: "Foo", author: "Bar")
    
    sut.addPageWith(index: 0, imageURL: imageURL(), audioURL: audioURL())
      sut.addPageWith(index: 1, imageURL: imageURL(), audioURL: audioURL())
    
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
