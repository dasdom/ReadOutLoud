//  Created by dasdom on 01.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

class Page: Codable {
  let id: UUID
  var duration: Double = 0
  
  init() {
    id = UUID()
  }
}
