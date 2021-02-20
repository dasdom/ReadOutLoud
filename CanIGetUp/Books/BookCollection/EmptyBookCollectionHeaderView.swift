//  Created by dasdom on 18.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class EmptyBookCollectionHeaderView: UICollectionReusableView {
  
  static var identifier: String {
    let identifier = self.description()
    return identifier
  }
  
  override init(frame: CGRect) {
    
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = NSLocalizedString("Go to settings to add books", comment: "")
    
    super.init(frame: frame)
    
    addSubview(label)
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor),
      label.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
  
  required init?(coder: NSCoder) { fatalError() }
}
