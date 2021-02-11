//  Created by dasdom on 01.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class PageTableViewCell: UITableViewCell {
  
  let pageImageView: UIImageView
  
  static var identifier: String {
    let identifier = self.description()
    print(identifier)
    return identifier
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    pageImageView = UIImageView()
    pageImageView.translatesAutoresizingMaskIntoConstraints = false
    pageImageView.contentMode = .scaleAspectFit
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
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

extension PageTableViewCell: PageTableViewCellProtocol {
  func update(with image: UIImage) {
    pageImageView.image = image
  }
}
