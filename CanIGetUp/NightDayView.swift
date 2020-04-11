//  Created by dasdom on 18.09.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import UIKit

class NightDayView: UIView {
  
  let imageView: UIImageView
  let button: UIButton
  
  override init(frame: CGRect) {
    
    imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "day")
    imageView.contentMode = .scaleAspectFill
    
    button = UIButton(type: .custom)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(named: "rabbit"), for: .normal)
    button.imageView?.contentMode = .scaleAspectFill
    
    super.init(frame: frame)
    
    addSubview(imageView)
    addSubview(button)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      button.bottomAnchor.constraint(equalTo: bottomAnchor),
      button.trailingAnchor.constraint(equalTo: trailingAnchor),
      button.widthAnchor.constraint(equalToConstant: 150),
      button.heightAnchor.constraint(equalTo: button.widthAnchor),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
