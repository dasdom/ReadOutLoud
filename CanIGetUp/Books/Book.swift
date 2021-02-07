//  Created by dasdom on 01.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

class Book: Codable {
  
  let id: UUID
  let title: String
  let author: String
  let creationDate: Date
  private var pages: [Page]
  var pageCount: Int {
    return pages.count
  }
  
  init(title: String, author: String) {
    self.id = UUID()
    self.title = title
    self.author = author
    self.creationDate = Date()
    self.pages = []
  }
  
  func addPageWith(index: Int, imageURL: URL, audioURL: URL) {
    
    let indices = pages.map({ $0.index })
    assert(false == indices.contains(index), "Page with this index already in the book")
    
    pages.append(Page(index: index, imageURL: imageURL, audioURL: audioURL))
  }
}
