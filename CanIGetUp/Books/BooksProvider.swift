//  Created by dasdom on 08.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

struct BooksProvider: BooksProviderProtocol {
    func save(books: [Book]) {
    do {
      let data = try JSONEncoder().encode(books)
      try data.write(to: FileManager.default.booksURL())
    } catch {
      print("error: \(error)")
    }
  }
  
  func loadBooks() -> [Book] {
    do {
      let data = try Data(contentsOf: FileManager.default.booksURL())
      let books = try JSONDecoder().decode([Book].self, from: data)
      return books
    } catch {
      print("error: \(error)")
    }
    return []
  }
  
  func save(imageData: Data, audioData: Data, duration: Double, inBook book: Book, forPage page: Page? = nil) -> Page? {
    do {
      let page = page ?? Page()
      page.duration = duration
      let imageURL = FileManager.default.pageImageURL(for: book, pageId: page.id)
      try imageData.write(to: imageURL)
      
      let audioURL = FileManager.default.pageAudioURL(for: book, pageId: page.id)
      try audioData.write(to: audioURL)
      
      return page
    } catch {
      print("error: \(error)")
    }
    return nil
  }
}
