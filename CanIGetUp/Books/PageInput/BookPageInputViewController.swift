//  Created by dasdom on 29.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit
import AVFoundation

class BookPageInputViewController: UIViewController {
  
  private let book: Book
  private let completion: () -> Void
  private var recorder: AVAudioRecorder?
  private var timer: Timer?
  private var powers: [Float] = []
  private var duration: Double = 0
  private var startDate: Date?
  private var contentView: BookPageInputView {
    return view as! BookPageInputView
  }
  
  init(book: Book, completion: @escaping () -> Void) {
    
    self.book = book
    self.completion = completion
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func loadView() {
    let contentView = BookPageInputView()
    
    contentView.imageInputButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
    contentView.recordPauseButton.addTarget(self, action: #selector(recordPause(_:)), for: .touchUpInside)
    contentView.doneButton.addTarget(self, action: #selector(done(_:)), for: .touchUpInside)
    contentView.nextButton.addTarget(self, action: #selector(next(_:)), for: .touchUpInside)
    
    contentView.recordPauseButton.isEnabled = false
    
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
    
    let recordingSession = AVAudioSession.sharedInstance()
    do {
      try recordingSession.setCategory(.record, mode: .default)
      recordingSession.requestRecordPermission({ granted in
        DispatchQueue.main.async {
          self.contentView.recordPauseButton.isEnabled = granted
        }
      })
    } catch {
      print("error: \(error)")
      fatalError()
    }
    
    updateButtons()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    try? AVAudioSession.sharedInstance().setActive(false)
  }
  
  @objc func addImage() {
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
    
    if recorder == nil || false == recorder?.isRecording {
      
      do {
        try AVAudioSession.sharedInstance().setActive(true)

        recorder = try AVAudioRecorder(url: FileManager.default.audioTmpPath(), settings: [AVFormatIDKey: kAudioFormatMPEG4AAC, AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue])
        recorder?.delegate = self
        recorder?.isMeteringEnabled = true
        
        startDate = Date()
        recorder?.record()
      } catch {
        print("error")
        return
      }
      
      timer?.invalidate()
      powers = []
      timer = Timer.scheduledTimer(withTimeInterval: 1/20.0, repeats: true, block: { timer in
        self.recorder?.updateMeters()
        if let power = self.recorder?.averagePower(forChannel: 0) {
          self.powers.append(power)
          if self.powers.count > 200 {
            self.powers.removeFirst()
          }
          self.contentView.waveformView.values = self.powers
        }
      })
      
      sender.setImage(UIImage(named: "stop"), for: .normal)
            
    } else {
      
      timer?.invalidate()
      
      print("stop")
      
      try? AVAudioSession.sharedInstance().setActive(false)

      sender.setImage(UIImage(named: "record"), for: .normal)
      
      if let startDate = startDate {
        duration = Date().timeIntervalSince(startDate)
      }
      recorder?.stop()
      
      DispatchQueue.main.async {
        self.updateButtons()
      }
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
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    print("flag: \(flag)")
  }
  
  func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
    print("error: \(error)")
  }
}

extension BookPageInputViewController: AVAudioPlayerDelegate {
  
}

extension BookPageInputViewController {
  @objc func next(_ sender: UIButton) {
    save()
    
    contentView.reset()
    updateButtons()
    addImage()
  }
  
  @objc func done(_ sender: UIButton) {
    save()
    
    dismiss(animated: true)
  }
  
  func save() {
    guard let image = contentView.imageView.image, let data = image.jpegData(compressionQuality: 0.3) else {
      return
    }
    
    guard let audioData = try? Data(contentsOf: FileManager.default.audioTmpPath()) else {
      return
    }
    
    if let page = BooksProvider().save(imageData: data, audioData: audioData, duration: duration, inBook: book) {
      book.add(page)
      FileManager.default.removeTmpAudio()
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
