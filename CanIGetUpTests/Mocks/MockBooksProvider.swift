//  Created by Dominik Hauser on 26/02/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation
@testable import CanIGetUp

class MockBooksProvider: BooksProviderProtocol {
  
  var bookTitles: [String]
  var lastSavedBooks: [Book] = []
  
  init(bookTitles: [String] = []) {
    self.bookTitles = bookTitles
  }
  
  func save(books: [Book]) {
    lastSavedBooks = books
  }
  
  func loadBooks() -> [Book] {
    return books(titles: bookTitles)
  }
  
  func save(imageData: Data, audioData: Data, duration: Double, inBook: Book) -> Page? {
    return nil
  }
  
  func books(titles: [String]) -> [Book] {
    return titles.map({ title in
      let book = Book(title: title)
      book.add(Page(duration: 20))
      return book
    })
  }
}
