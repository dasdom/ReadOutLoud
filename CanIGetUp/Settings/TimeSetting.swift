//  Created by dasdom on 18.09.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import Foundation

class TimeSetting : Codable {
  let name: String
  var time: Time
  var expanded = false
  
  internal init(name: String, time: Time) {
    self.name = name
    self.time = time
  }
  
  enum CodingKeys: String, CodingKey {
    case name
    case time
  }
}
