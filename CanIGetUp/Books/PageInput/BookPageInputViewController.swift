//  Created by dasdom on 29.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit
import AVFoundation

class BookPageInputViewController: UIViewController {
  
  private let book: Book
  private let completion: () -> Void
  private let recorder: AVAudioRecorder
  private var player: AVAudioPlayer?
  private var timer: Timer?
  private var powers: [Float] = []
  private var contentView: BookPageInputView {
    return view as! BookPageInputView
  }
  
  init(book: Book, completion: @escaping () -> Void) {
    
    self.book = book
    self.completion = completion
    
    do {
      try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
      recorder = try AVAudioRecorder(url: FileManager.default.audioTmpPath(), settings: [AVFormatIDKey: kAudioFormatMPEG4AAC, AVSampleRateKey: 44100.0, AVNumberOfChannelsKey: 2])
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
    contentView.doneButton.addTarget(self, action: #selector(done(_:)), for: .touchUpInside)
    contentView.nextButton.addTarget(self, action: #selector(next(_:)), for: .touchUpInside)
    
    view = contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if #available(iOS 11.0, *) {
    } else {
      NSLayoutConstraint.activate([
        contentView.stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
        contentView.stackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
      ])
    }
    
    updateButtons()
    
//    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save(_:)))
//    navigationItem.rightBarButtonItem = saveButton
  }
  
  @objc func addImage(_ sender: UIButton) {
    let imagePicker = UIImagePickerController()
    #if targetEnvironment(simulator)
    imagePicker.sourceType = .photoLibrary
    #else
    imagePicker.sourceType = .camera
    #endif
    imagePicker.delegate = self
    present(imagePicker, animated: true)
  }
  
  @objc func recordPause(_ sender: UIButton) {
    
    if false == recorder.isRecording {
      
      timer?.invalidate()
      powers = []
      timer = Timer.scheduledTimer(withTimeInterval: 1/20.0, repeats: true, block: { timer in
        self.recorder.updateMeters()
        let power = self.recorder.averagePower(forChannel: 0)
        self.powers.append(power)
        if self.powers.count > 200 {
          self.powers.removeFirst()
        }
        self.contentView.waveformView.values = self.powers
      })
      
      print("record")
      do {
        try AVAudioSession.sharedInstance().setActive(true, options: [])
      } catch {
        print("error: \(error)")
      }
      
      sender.setImage(UIImage(named: "stop"), for: .normal)
      recorder.record()
            
    } else {
      
      timer?.invalidate()
      
      print("stop")
      
      sender.setImage(UIImage(named: "record"), for: .normal)
      recorder.stop()
      
      do {
        try AVAudioSession.sharedInstance().setActive(false, options: [])
      } catch {
        print("error: \(error)")
      }
      
      updateButtons()
    }
  }
  
//  @objc func stop(_ sender: UIButton) {
//
//    print("stop")
//
//    recorder.stop()
//
//    do {
//      try AVAudioSession.sharedInstance().setActive(false, options: [])
//    } catch {
//      print("error: \(error)")
//    }
//  }
//
//  @objc func play(_ sender: UIButton) {
//
//    print("play")
//
//    if !recorder.isRecording {
//      do {
//        try AVAudioSession.sharedInstance().setCategory(.playback)
//        player = try AVAudioPlayer(contentsOf: FileManager.default.audioTestPath())
//        player?.delegate = self
//        player?.play()
//      } catch {
//        print("error: \(error)")
//      }
//    }
//  }
}

extension BookPageInputViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    dismiss(animated: true)
        
    contentView.imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    
    updateButtons()
  }
}

extension BookPageInputViewController: AVAudioRecorderDelegate {
  
}

extension BookPageInputViewController: AVAudioPlayerDelegate {
  
}

extension BookPageInputViewController {
  @objc func next(_ sender: UIButton) {
    save()
    
    contentView.reset()
  }
  
  @objc func done(_ sender: UIButton) {
    save()
    
    dismiss(animated: true)
  }
  
  func save() {
    guard let image = contentView.imageView.image, let data = image.jpegData(compressionQuality: 0.8) else {
      return
    }
    
    guard let audioData = try? Data(contentsOf: FileManager.default.audioTmpPath()) else {
      return
    }
    
    if let page = BooksProvider.save(imageData: data, audioData: audioData, inBook: book) {
      book.add(page)
      completion()
    }
  }
  
  func updateButtons() {
    if let _ = contentView.imageView.image, let _ = try? Data(contentsOf: FileManager.default.audioTmpPath()) {
      contentView.nextButton.isEnabled = true
    } else {
      contentView.nextButton.isEnabled = false
    }
  }
}
