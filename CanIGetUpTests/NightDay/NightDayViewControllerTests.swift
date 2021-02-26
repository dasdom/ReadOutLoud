//  Created by Dominik Hauser on 26/02/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class NightDayViewControllerTests: XCTestCase {
  
  var sut: NightDayViewController!
  
  override func setUpWithError() throws {
    sut = NightDayViewController()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_loadingView_setsNightDayView() throws {
    
    sut.loadViewIfNeeded()
    
    XCTAssertTrue(sut.view is NightDayView)
  }
}
