//  Created by dasdom on 01.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class PageTableViewCell: UITableViewCell {
  
  let pageImageView: UIImageView
  let label: UILabel
  
  static var identifier: String {
    let identifier = self.description()
    print(identifier)
    return identifier
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

    pageImageView = UIImageView()
    pageImageView.translatesAutoresizingMaskIntoConstraints = false
    pageImageView.contentMode = .scaleAspectFit
    
    label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .headline)

    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(pageImageView)
    contentView.addSubview(label)

    NSLayoutConstraint.activate([
      pageImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
      pageImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      pageImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
      pageImageView.widthAnchor.constraint(equalTo: pageImageView.heightAnchor),
      
      label.leadingAnchor.constraint(equalTo: pageImageView.trailingAnchor, constant: 20),
      label.centerYAnchor.constraint(equalTo: pageImageView.centerYAnchor),
    ])
    
  }

  required init?(coder: NSCoder) { fatalError() }
}

extension PageTableViewCell: PageTableViewCellProtocol {
  func update(with image: UIImage, durationString: String) {
    pageImageView.image = image
    label.text = durationString
  }
}
