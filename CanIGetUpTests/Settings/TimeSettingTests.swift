//  Created by Dominik Hauser on 13/03/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class TimeSettingTests: XCTestCase {
  
  func test_encodeExpanded_decodesNotExpanded() throws {
    let sut = TimeSetting(name: "Foo", time: Time(hour: 1, minute: 2))
    sut.expanded = true
    
    let data = try JSONEncoder().encode(sut)
    let decoded = try JSONDecoder().decode(TimeSetting.self, from: data)
    
    XCTAssertEqual(decoded.expanded, false)
  }
}
