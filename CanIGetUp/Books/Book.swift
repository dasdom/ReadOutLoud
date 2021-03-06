//  Created by dasdom on 01.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

class Book: Codable {
  
  let id: UUID
  let title: String
//  let author: String
  let creationDate: Date
  private var pages: [Page]
  var pageCount: Int {
    return pages.count
  }
  
  init(title: String) {
    self.id = UUID()
    self.title = title
//    self.author = author
    self.creationDate = Date()
    self.pages = []
  }
  
  func add(_ page: Page) {
    
    let ids = pages.map({ $0.id })
    assert(false == ids.contains(page.id), "Page with this index already in the book")
    
    pages.append(page)
  }
  
  func indexFor(page: Page) -> Int? {
    return pages.firstIndex(where: { $0.id == page.id })
  }
  
  func pageForIndex(_ index: Int) -> Page? {
    guard pages.count > index else {
      return nil
    }
    return pages[index]
  }
  
  func pageImageURL(index: Int) -> URL? {
    guard let page = pageForIndex(index) else {
      return nil
    }
    return FileManager.default.pageImageURL(for: self, pageId: page.id)
  }
  
  func pageAudioURL(index: Int) -> URL? {
    guard let page = pageForIndex(index) else {
      return nil
    }
    return FileManager.default.pageAudioURL(for: self, pageId: page.id)
  }
  
  func removePage(at index: Int) {
    if pages.count > index {
      pages.remove(at: index)
    }
  }
}
