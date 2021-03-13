//  Created by dasdom on 10.04.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

class ImageCreditCell: UITableViewCell {

  let creditImageView: UIImageView
  let nameHostView: UIView
  let nameLabel: UILabel
  
  static var identifier: String {
    return NSStringFromClass(self)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    creditImageView = UIImageView()
    nameHostView = UIView()
    nameLabel = UILabel()
    
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
    setupUI()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  func setupUI() {
    
    contentView.clipsToBounds = true
    
    creditImageView.translatesAutoresizingMaskIntoConstraints = false
    creditImageView.contentMode = .scaleAspectFill
    
    nameHostView.translatesAutoresizingMaskIntoConstraints = false
    nameHostView.backgroundColor = .init(white: 0.2, alpha: 0.5)
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.textColor = .white
    nameLabel.font = .preferredFont(forTextStyle: .footnote)
    nameLabel.numberOfLines = 0
    
    contentView.addSubview(creditImageView)
    contentView.addSubview(nameHostView)
    nameHostView.addSubview(nameLabel)
    
    NSLayoutConstraint.activate([
      creditImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      creditImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      creditImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      creditImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      nameHostView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      nameHostView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      nameHostView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      nameLabel.topAnchor.constraint(equalTo: nameHostView.topAnchor, constant:5),
      nameLabel.leadingAnchor.constraint(equalTo: nameHostView.leadingAnchor, constant:10),
      nameLabel.bottomAnchor.constraint(equalTo: nameHostView.bottomAnchor, constant:-5),
      nameLabel.trailingAnchor.constraint(equalTo: nameHostView.trailingAnchor, constant:-10),
    ])
  }
  
  func update(with imageCredit: ImageCredit) {
    creditImageView.image = UIImage(named: imageCredit.imageName)
    nameLabel.text = imageCredit.creditText
  }
}
