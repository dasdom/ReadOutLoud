//  Created by dasdom on 01.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class BookDetailsView: UIView {
  
  let titleTextField: UITextField
  let authorTextField: UITextField
  let coverImageView: UIImageView
  let stackView: UIStackView
  
  override init(frame: CGRect) {
    
    titleTextField = UITextField()
    titleTextField.borderStyle = .bezel
    titleTextField.placeholder = "Title"
    
    authorTextField = UITextField()
    authorTextField.borderStyle = .bezel
    authorTextField.placeholder = "Author"
    
    coverImageView = UIImageView()
    
    stackView = UIStackView(arrangedSubviews: [titleTextField, authorTextField, coverImageView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 4
    
    super.init(frame: frame)
    
    backgroundColor = .white
    
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
    ])
  }
  
  required init?(coder: NSCoder) { fatalError() }
}
