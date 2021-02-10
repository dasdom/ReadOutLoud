//  Created by dasdom on 08.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
@testable import CanIGetUp

class MockPageCell: UITableViewCell, PageCellProtocol {
  
  var lastImageFromUpdate: UIImage?
  
  func update(with image: UIImage) {
    lastImageFromUpdate = image
  }
}
