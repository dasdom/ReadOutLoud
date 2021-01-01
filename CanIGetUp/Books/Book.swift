//  Created by dasdom on 01.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

class Book: Codable {
  
  let id: UUID
  let title: String
  let author: String
  let creationDate: Date
  var pages: [Page]
  
  init(title: String, author: String) {
    self.id = UUID()
    self.title = title
    self.author = author
    self.creationDate = Date()
    self.pages = []
  }
}
