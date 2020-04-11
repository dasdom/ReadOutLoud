//  Created by dasdom on 18.09.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import Foundation

struct Time : Codable, Comparable {
  let hour: Int
  let minute: Int
  
  var date: Date {
    
    let calendar = Calendar(identifier: .gregorian)
    
    var components = DateComponents()
    components.hour = hour
    components.minute = minute
    
    guard let date = calendar.date(from: components) else { fatalError() }
    return date
  }
  
  var string: String {
    return String(format: "%02d:%02d", hour, minute)
  }
  
  static func < (lhs: Self, rhs: Self) -> Bool {
    if lhs.hour < rhs.hour {
      return true
    } else if lhs.hour == rhs.hour, lhs.minute < rhs.minute {
      return true
    }
    return false
  }
}

extension Time {
  init(date: Date) {
    let calendar = Calendar(identifier: .gregorian)
    
    let components = calendar.dateComponents([.hour, .minute], from: date)
    
    guard let hour = components.hour, let minute = components.minute else { fatalError() }
    self.hour = hour
    self.minute = minute
  }
}
