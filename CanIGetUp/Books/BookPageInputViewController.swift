//  Created by dasdom on 29.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit
import AVFoundation

class BookPageInputViewController: UIViewController {
  
  private let book: Book
  private let recorder: AVAudioRecorder
  private var player: AVAudioPlayer?
  private var contentView: BookPageInputView {
    return view as! BookPageInputView
  }
  
  init(book: Book) {
    
    self.book = book
    
    do {
      try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
      recorder = try AVAudioRecorder(url: FileManager.default.audioTestPath(), settings: [AVFormatIDKey: kAudioFormatMPEG4AAC, AVSampleRateKey: 44100.0, AVNumberOfChannelsKey: 2])
    } catch {
      print("error: \(error)")
      fatalError()
    }
    
    super.init(nibName: nil, bundle: nil)
  
    recorder.delegate = self
    recorder.isMeteringEnabled = true
    
    recorder.prepareToRecord()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func loadView() {
    let contentView = BookPageInputView()
    
    contentView.imageInputButton.addTarget(self, action: #selector(addImage(_:)), for: .touchUpInside)
    contentView.recordPauseButton.addTarget(self, action: #selector(recordPause(_:)), for: .touchUpInside)
    contentView.stopButton.addTarget(self, action: #selector(stop(_:)), for: .touchUpInside)
    contentView.playButton.addTarget(self, action: #selector(play(_:)), for: .touchUpInside)
    
    view = contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NSLayoutConstraint.activate([
      contentView.stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
      contentView.stackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
    ])
    
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save(_:)))
    navigationItem.rightBarButtonItem = saveButton

  }
  
  @objc func addImage(_ sender: UIButton) {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.delegate = self
    present(imagePicker, animated: true)
  }
  
  @objc func recordPause(_ sender: UIButton) {
    
    if !recorder.isRecording {
      print("pause")
      do {
        try AVAudioSession.sharedInstance().setActive(true, options: [])
      } catch {
        print("error: \(error)")
      }
      
      sender.setTitle("Pause", for: .normal)
      recorder.record()
      
    } else {
      print("record")
      
      sender.setTitle("Record", for: .normal)
      recorder.pause()
      
    }
  }
  
  @objc func stop(_ sender: UIButton) {
    
    print("stop")
    
    recorder.stop()
    
    do {
      try AVAudioSession.sharedInstance().setActive(false, options: [])
    } catch {
      print("error: \(error)")
    }
  }
  
  @objc func play(_ sender: UIButton) {
    
    print("play")
    
    if !recorder.isRecording {
      do {
        try AVAudioSession.sharedInstance().setCategory(.playback)
        player = try AVAudioPlayer(contentsOf: FileManager.default.audioTestPath())
        player?.delegate = self
        player?.play()
      } catch {
        print("error: \(error)")
      }
    }
  }
}

extension BookPageInputViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    dismiss(animated: true)
        
    contentView.imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
  }
}

extension BookPageInputViewController: AVAudioRecorderDelegate {
  
}

extension BookPageInputViewController: AVAudioPlayerDelegate {
  
}

extension BookPageInputViewController {
  @objc func save(_ sender: UIBarButtonItem) {
    
    guard let image = contentView.imageView.image, let data = image.jpegData(compressionQuality: 0.8) else {
      return
    }
    
    BooksProvider.save(imageData: data, inBook: book, forPageIndex: book.pageCount)
    
    dismiss(animated: true)
  }
}
