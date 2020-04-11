//  Created by dasdom on 18.09.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import Foundation

extension FileManager {
  static func documentsURL() -> URL {
    guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { fatalError() }
    return url
  }
  
  static func settingsPath() -> URL {
    return documentsURL().appendingPathComponent("settings.json")
  }
}
