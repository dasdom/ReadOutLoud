//  Created by Dom on 06.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class PageTests: XCTestCase {

  override func setUpWithError() throws {
  }
  
  override func tearDownWithError() throws {
  }

  func test_init_takesIndexImageURLAndAudioURL() {
    let page = Page(index: 0)
    
    XCTAssertNotNil(page)
  }
}
