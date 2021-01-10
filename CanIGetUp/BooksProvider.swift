//  Created by dasdom on 08.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

struct BooksProvider {
  static func save(books: [Book]) {
    do {
      let data = try JSONEncoder().encode(books)
      try data.write(to: FileManager.default.booksURL())
    } catch {
      print("error: \(error)")
    }
  }
  
  static func loadBooks() -> [Book] {
    do {
      let data = try Data(contentsOf: FileManager.default.booksURL())
      let books = try JSONDecoder().decode([Book].self, from: data)
      return books
    } catch {
      print("error: \(error)")
    }
    return []
  }
  
  static func save(imageData: Data, inBook book: Book, forPageIndex pageIndex: Int) {
    do {
      try imageData.write(to: FileManager.default.pageURL(for: book, pageIndex: pageIndex))
    } catch {
      print("error: \(error)")
    }
  }
}