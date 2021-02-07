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
    let imageURL = URL(string: "image")!
    let audioURL = URL(string: "audio")!
    let page = Page(index: 0, imageURL: imageURL, audioURL: audioURL)
    
    XCTAssertNotNil(page)
  }
}
