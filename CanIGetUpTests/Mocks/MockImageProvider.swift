//  Created by dasdom on 17.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
@testable import CanIGetUp

struct MockImageProvider: ImageProviderProtocol {
  func cover(for book: Book) -> UIImage? {
    return UIImage()
  }
}
