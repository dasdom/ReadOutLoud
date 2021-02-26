//  Created by Dominik Hauser on 26/02/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import Foundation

protocol BooksProviderProtocol {
  func save(books: [Book])
  func loadBooks() -> [Book]
  func save(imageData: Data, audioData: Data, duration: Double, inBook: Book) -> Page?
}
