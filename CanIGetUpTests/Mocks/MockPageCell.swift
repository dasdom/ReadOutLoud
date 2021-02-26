//  Created by dasdom on 08.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
@testable import CanIGetUp

class MockPageCell: UITableViewCell, PageTableViewCellProtocol {
 
  var lastImageFromUpdate: UIImage?
  var lastDurationString: String?
  
  func update(with image: UIImage, durationString: String) {
    lastImageFromUpdate = image
    lastDurationString = durationString
  }
}
