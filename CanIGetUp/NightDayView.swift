//  Created by dasdom on 18.09.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import UIKit

class NightDayView: UIView {
  
  let imageView: UIImageView
  let rabbitButton: UIButton
  let booksButton: UIButton
  
  override init(frame: CGRect) {
    
    imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "day")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    
    rabbitButton = UIButton(type: .custom)
    rabbitButton.translatesAutoresizingMaskIntoConstraints = false
    rabbitButton.setImage(UIImage(named: "rabbit"), for: .normal)
    rabbitButton.imageView?.contentMode = .scaleAspectFill
    
    booksButton = UIButton(type: .custom)
    booksButton.translatesAutoresizingMaskIntoConstraints = false
    booksButton.setImage(UIImage(named: "books"), for: .normal)
    booksButton.imageView?.contentMode = .scaleAspectFill
    
    super.init(frame: frame)
    
    addSubview(imageView)
    addSubview(booksButton)
    addSubview(rabbitButton)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      rabbitButton.bottomAnchor.constraint(equalTo: bottomAnchor),
      rabbitButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      rabbitButton.widthAnchor.constraint(equalToConstant: 150),
      rabbitButton.heightAnchor.constraint(equalTo: rabbitButton.widthAnchor),
      
      booksButton.bottomAnchor.constraint(equalTo: bottomAnchor),
      booksButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      booksButton.widthAnchor.constraint(equalToConstant: 150),
      booksButton.heightAnchor.constraint(equalTo: booksButton.widthAnchor),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
