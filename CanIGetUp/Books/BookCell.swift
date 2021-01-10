//  Created by dasdom on 01.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class BookCell: UICollectionViewCell {
  let imageView: UIImageView
  let titleLabel: UILabel
  
  static var identifier: String {
    let identifier = self.description()
    print(identifier)
    return identifier
  }
  
  override init(frame: CGRect) {
    
    imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    
    titleLabel = UILabel()
    titleLabel.numberOfLines = 2
    titleLabel.textAlignment = .center
    titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    
    let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    
    super.init(frame: frame)
    
    contentView.backgroundColor = .white
    
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
    ])
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  func update(with book: Book) {
    let coverURL = FileManager.default.bookCoverURL(for: book)
    let image = UIImage(contentsOfFile: coverURL.path)
    imageView.image = image
    
    titleLabel.text = book.title
  }
}
