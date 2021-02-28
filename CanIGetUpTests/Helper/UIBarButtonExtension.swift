//  Created by Dominik Hauser on 28/02/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
import XCTest

extension UIBarButtonItem {
  func performAction() throws {
    let unwrappedTarget = try XCTUnwrap(target as? UIViewController)
    let unwrappedAction = try XCTUnwrap(action)
    unwrappedTarget.perform(unwrappedAction)
  }
}
