//  Created by dasdom on 01.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class PageCell: UITableViewCell {
  
  let pageImageView: UIImageView
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    pageImageView = UIImageView()
    pageImageView.translatesAutoresizingMaskIntoConstraints = false
    
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
