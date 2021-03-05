//  Created by dasdom on 10.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
  let pageImageView: UIImageView

  static var identifier: String {
    let identifier = self.description()
//    print(identifier)
    return identifier
  }

  override init(frame: CGRect) {
    
    pageImageView = UIImageView()
    pageImageView.translatesAutoresizingMaskIntoConstraints = false
    pageImageView.contentMode = .scaleAspectFit
    
    super.init(frame: frame)
    
    contentView.backgroundColor = .black
    contentView.addSubview(pageImageView)
    
    NSLayoutConstraint.activate([
      pageImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      pageImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      pageImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      pageImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
  
  required init?(coder: NSCoder) { fatalError() }
}

extension PageCollectionViewCell: PageCollectionViewCellProtocol {
  func update(with image: UIImage) {
    pageImageView.image = image
  }
}
