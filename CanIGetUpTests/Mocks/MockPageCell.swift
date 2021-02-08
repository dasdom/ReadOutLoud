//  Created by dasdom on 08.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
@testable import CanIGetUp

class MockPageCell: UITableViewCell, PageCellProtocol {
  
  var lastPageFromUpdate: Page?
  
  func update(with page: Page) {
    lastPageFromUpdate = page
  }
}
