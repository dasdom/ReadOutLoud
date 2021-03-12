//  Created by Dominik Hauser on 07/03/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
@testable import CanIGetUp

class SpyBookDetailsViewController: BookDetailsViewController {

  var lastPresented: UIViewController? = nil
  
  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    lastPresented = viewControllerToPresent
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }
}
