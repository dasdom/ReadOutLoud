//  Created by dasdom on 17.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
@testable import CanIGetUp

class MockBookCell: UICollectionViewCell, BookCellProtocol {
  
  var updateCallCount = 0
  
  func update(with: Book) {
    updateCallCount += 1
  }
}
