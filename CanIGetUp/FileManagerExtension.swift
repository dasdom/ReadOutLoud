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
  
  func pageImageURL(for book: Book, pageIndex: Int) -> URL {
    let bookURL = documentsURL().appendingPathComponent("\(book.id)")
    let pageURL = bookURL.appendingPathComponent("\(pageIndex)_image")
    return pageURL
  }
  
  func pageAudioURL(for book: Book, pageIndex: Int) -> URL {
    let bookURL = documentsURL().appendingPathComponent("\(book.id)")
    let pageURL = bookURL.appendingPathComponent("\(pageIndex)_audio")
    return pageURL
  }
}
