//  Created by dasdom on 21.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
@testable import CanIGetUp

class MockBook: Book {
  
  override func pageImageURL(index: Int) -> URL? {
    return Bundle(for: MockBook.self).url(forResource: "blume", withExtension: "jpg")
  }
  
  override func pageAudioURL(index: Int) -> URL? {
    return URL(string: "foo")
  }
  
  override func indexFor(page: Page) -> Int? {
    return 0
  }
}
