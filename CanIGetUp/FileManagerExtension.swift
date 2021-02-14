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
  
  func audioTmpPath() -> URL {
    return documentsURL().appendingPathComponent("tmp_record.m4a")
  }
  
  func removeTmpAudio() {
    let url = audioTmpPath()
    try? removeItem(at: url)
  }
  
  func createBooksDiretory(for book: Book) {
    let bookURL = documentsURL().appendingPathComponent("\(book.id)")
    do {
      try self.createDirectory(at: bookURL, withIntermediateDirectories: false, attributes: nil)
    } catch {
      print("error: \(error)")
    }
  }
  
  func removeBooksDirectory(for book: Book) {
    let bookURL = documentsURL().appendingPathComponent("\(book.id)")
    do {
      try removeItem(at: bookURL)
    } catch {
      print("error: \(error)")
    }
  }
  
  func bookCoverURL(for book: Book) -> URL {
    let bookURL = documentsURL().appendingPathComponent("\(book.id)")
    let coverURL = bookURL.appendingPathComponent("cover")
    return coverURL
  }
  
  func booksURL() -> URL {
    let booksURL = documentsURL().appendingPathComponent("books.json")
    return booksURL
  }
  
  func pageImageURL(for book: Book, pageId: UUID) -> URL {
    let bookURL = documentsURL().appendingPathComponent("\(book.id)")
    let pageURL = bookURL.appendingPathComponent("\(pageId)_image")
    return pageURL
  }
  
  func pageAudioURL(for book: Book, pageId: UUID) -> URL {
    let bookURL = documentsURL().appendingPathComponent("\(book.id)")
    let pageURL = bookURL.appendingPathComponent("\(pageId)_audio")
    return pageURL
  }
}
