//  Created by dasdom on 31.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class MockNavigationController: UINavigationController {
  
  var pushedViewController: UIViewController? = nil
  var dismissCallCount = 0
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    pushedViewController = viewController
    super.pushViewController(viewController, animated: false)
  }
  
  override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
    dismissCallCount += 1
  }
}
