//  Created by dasdom on 10.04.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell {

  let headlineLabel: UILabel
  let bodyLabel: UILabel
  
  static var identifier: String {
    return NSStringFromClass(self)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    headlineLabel = UILabel()
    bodyLabel = UILabel()
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupUI() {
    headlineLabel.font = .preferredFont(forTextStyle: .headline)
    headlineLabel.numberOfLines = 0
    
    bodyLabel.font = .preferredFont(forTextStyle: .body)
    bodyLabel.numberOfLines = 0
    
    let stackView = UIStackView(arrangedSubviews: [headlineLabel, bodyLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 5
    stackView.axis = .vertical
    
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
    ])
  }
  
  func update(with aboutItem: AboutItem) {
    headlineLabel.text = aboutItem.headline
    bodyLabel.text = aboutItem.body
  }
}
