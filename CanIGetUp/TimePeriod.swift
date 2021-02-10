//  Created by dasdom on 23.09.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import Foundation

enum TimePeriod {
  case day
  case night
  
  init(date: Date, start: Time, end: Time) {
    let dateTime = Time(date: date)
//    print("\(dateTime), \(start), \(end)")
    if start > end {
      if start <= dateTime || dateTime < end {
        self = .night
      } else {
        self = .day
      }
    } else if start <= dateTime, dateTime < end {
      self = .night
    } else {
      self = .day
    }
  }
}
