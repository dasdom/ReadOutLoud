//  Created by dasdom on 29.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

class BookPageInputView: UIView {

  let imageView: UIImageView
  let imageInputButton: UIButton
  let recordPauseButton: UIButton
  let stopButton: UIButton
  let playButton: UIButton
  let stackView: UIStackView
  
  override init(frame: CGRect) {
    
    imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .yellow
    
    imageInputButton = UIButton(type: .system)
    imageInputButton.setTitle("Take image", for: .normal)
    
    recordPauseButton = UIButton(type: .system)
    recordPauseButton.setTitle("Record", for: .normal)
    
    stopButton = UIButton(type: .system)
    stopButton.setTitle("Stop", for: .normal)
    
    playButton = UIButton(type: .system)
    playButton.setTitle("Play", for: .normal)

    let audioControlButtonStackView = UIStackView(arrangedSubviews: [playButton, stopButton, recordPauseButton])
    audioControlButtonStackView.distribution = .fillEqually
    
    stackView = UIStackView(arrangedSubviews: [imageView, imageInputButton, audioControlButtonStackView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical

    super.init(frame: frame)
    
    backgroundColor = .white
    
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
