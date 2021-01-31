//  Created by dasdom on 17.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class BookCellTests: XCTestCase {
  
  var sut: BookCell!
  
  override func setUpWithError() throws {
    sut = BookCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
  }
  
  override func tearDownWithError() throws {
    
  }
  
  func test_update_setsImage() {
    sut.imageProvider = MockImageProvider()
    sut.update(with: Book(title: "Foo", author: "Bar"))
    
    XCTFail("implement rest of this test")
  }
}
