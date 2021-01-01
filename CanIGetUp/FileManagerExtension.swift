//  Created by dasdom on 18.09.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import Foundation

extension FileManager {
  func documentsURL() -> URL {
    guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { fatalError() }
    return url
  }
  
  func settingsPath() -> URL {
    return documentsURL().appendingPathComponent("settings.json")
  }
  
  func audioTestPath() -> URL {
    return documentsURL().appendingPathComponent("test_record.m4a")
  }
  
  func bookCover(for book: Book) -> URL {
    let bookURL = documentsURL().appendingPathComponent("\(book.id)")
    let coverURL = bookURL.appendingPathComponent("cover")
    return coverURL
  }
}
