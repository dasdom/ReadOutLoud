//  Created by dasdom on 29.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

class BookPageInputView: UIView {

  let imageView: UIImageView
  let imageInputButton: UIButton
  let recordPauseButton: UIButton
  let waveformView: WaveformView
//  let stopButton: UIButton
//  let playButton: UIButton
  let stackView: UIStackView
  
  override init(frame: CGRect) {
    
    imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = true
    
    imageInputButton = UIButton(type: .system)
    imageInputButton.translatesAutoresizingMaskIntoConstraints = false
    imageInputButton.setImage(UIImage(named: "plus"), for: .normal)
//    imageInputButton.setTitle("Take image", for: .normal)
    
    recordPauseButton = UIButton(type: .system)
    recordPauseButton.translatesAutoresizingMaskIntoConstraints = false
    recordPauseButton.setImage(UIImage(named: "record"), for: .normal)
//    recordPauseButton.setTitle("Record", for: .normal)

//    let audioControlButtonStackView = UIStackView(arrangedSubviews: [playButton, stopButton, recordPauseButton])
//    audioControlButtonStackView.distribution = .fillEqually
    
    waveformView = WaveformView()
    waveformView.backgroundColor = .black
    
    let recordHostView = UIView()
    
    stackView = UIStackView(arrangedSubviews: [imageView, waveformView, recordHostView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical

    super.init(frame: frame)
    
    backgroundColor = .white
    
    imageView.addSubview(imageInputButton)
    recordHostView.addSubview(recordPauseButton)
    addSubview(stackView)
    
    var layoutConstraints = [
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      imageInputButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      imageInputButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
      imageInputButton.widthAnchor.constraint(equalToConstant: 50),
      imageInputButton.heightAnchor.constraint(equalToConstant: 50),
      
      waveformView.heightAnchor.constraint(equalToConstant: 80),
      
      recordPauseButton.topAnchor.constraint(equalTo: recordHostView.topAnchor, constant: 4),
      recordPauseButton.bottomAnchor.constraint(equalTo: recordHostView.bottomAnchor, constant: 4),
      recordPauseButton.centerXAnchor.constraint(equalTo: recordHostView.centerXAnchor),
      recordPauseButton.widthAnchor.constraint(equalToConstant: 50),
      recordPauseButton.heightAnchor.constraint(equalToConstant: 50),
    ]
    
    if #available(iOS 11.0, *) {
      layoutConstraints.append(contentsOf: [
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
        stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
      ])
    }
    
    NSLayoutConstraint.activate(layoutConstraints)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
