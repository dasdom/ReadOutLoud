//  Created by dasdom on 17.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

struct ImageProvider: ImageProviderProtocol {
  
  static let shared = ImageProvider()
  
  func cover(for book: Book) -> UIImage? {
    let coverURL = FileManager.default.bookCoverURL(for: book)
    return UIImage(contentsOfFile: coverURL.path)
  }
}
