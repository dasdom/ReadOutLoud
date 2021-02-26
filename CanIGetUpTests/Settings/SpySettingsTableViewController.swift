//  Created by Dominik Hauser on 26/02/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
@testable import CanIGetUp

class SpySettingsTableViewController: SettingsTableViewController {

  var dismissCallCount = 0
  
  override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
    dismissCallCount += 1
    super.dismiss(animated: flag, completion: completion)
  }
}
