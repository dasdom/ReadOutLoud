//  Created by dasdom on 16.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class AddBookCell: UICollectionViewCell {
  
  static var identifier: String {
    let identifier = self.description()
    return identifier
  }
  
  override init(frame: CGRect) {
    
    let image = UIImage(named: "plus")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    super.init(frame: frame)
    
    contentView.addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 50),
      imageView.heightAnchor.constraint(equalToConstant: 50),
    ])
  }
  
  required init?(coder: NSCoder) { fatalError() }
}
