//  Created by dasdom on 09.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class PageCellTests: XCTestCase {
  
  var sut: PageCell!
  
  override func setUpWithError() throws {
    sut = PageCell()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_pageUpdate_setsImage() {
    let url = Bundle(for: PageCellTests.self).url(forResource: "blume", withExtension: "jpg")!
    let image = UIImage(contentsOfFile: url.path)!
    
    sut.update(with: image)
    
    XCTAssertNotNil(sut.pageImageView.image)
  }
}