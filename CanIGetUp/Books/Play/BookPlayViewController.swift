//  Created by dasdom on 10.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "Cell"

class BookPlayViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let book: Book
  private var player: AVAudioPlayer?
  private var currentPage: Int = 0
  private var displayLink: CADisplayLink? = nil
  private var progressView: UIProgressView
  
  init(book: Book) {
    
    self.book = book
    
//    let flowLayout = UICollectionViewFlowLayout()
//    flowLayout.scrollDirection = .horizontal
//    flowLayout.sectionInset = .zero
//    flowLayout.minimumInteritemSpacing = 0
//    flowLayout.minimumLineSpacing = 0
    
    let layout = PageStackLayout()
    
    progressView = UIProgressView(progressViewStyle: .bar)
    progressView.progressTintColor = .white
    
    super.init(collectionViewLayout: layout)
    
    displayLink = CADisplayLink(target: self, selector: #selector(updateProgress))
    
    collectionView.addSubview(progressView)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: PageCollectionViewCell.identifier)
    
    collectionView?.isPagingEnabled = true
    collectionView?.isScrollEnabled = false
    
    progressView.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: 20)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let previous = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(previousPage))
    let next = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(nextPage))
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    toolbarItems = [previous, spacer, next]
    navigationController?.setToolbarHidden(false, animated: false)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    playAudio(for: 0)
    
    UIApplication.shared.isIdleTimerDisabled = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    player?.stop()
    player = nil
    displayLink?.remove(from: .current, forMode: .common)
    displayLink = nil
    UIApplication.shared.isIdleTimerDisabled = false
  }
  
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    let contentOffset = CGFloat(currentPage) * size.width
    collectionView.setContentOffset(CGPoint(x: contentOffset, y: collectionView.contentOffset.y), animated: true)
    collectionView.collectionViewLayout.invalidateLayout()
    
    progressView.frame.origin.x = collectionView.contentOffset.x
    progressView.frame.size.width = size.width
  }
  
  // MARK: UICollectionViewDataSource
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return book.pageCount
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionViewCell.identifier, for: indexPath)
    
    if let url = book.pageImageURL(index: indexPath.item),
       let image = UIImage(contentsOfFile: url.path),
       let cell = cell as? PageCollectionViewCellProtocol {
      cell.update(with: image)
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.frame.inset(by: collectionView.safeAreaInsets).size
  }
  
  func playAudio(for index: Int) {
//    print("page: \(index)")
    player?.stop()
    guard let url = book.pageAudioURL(index: index) else {
      return
    }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback)
      player = nil
      player = try AVAudioPlayer(contentsOf: url)
      player?.delegate = self
      player?.play()
      
      displayLink?.add(to: .current, forMode: .common)
    } catch {
      print("error: \(error)")
    }
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    progressView.frame.origin.x = scrollView.contentOffset.x
  }
  
  @objc func updateProgress() {
    if let currentTime = player?.currentTime, let total = player?.duration {
      progressView.progress = Float(currentTime / total)
    }
  }
  
  func start(at page: Int) {
    let width = collectionView.contentSize.width / CGFloat(book.pageCount) //collectionView.frame.inset(by: collectionView.safeAreaInsets).size.width
    let offset = collectionView.safeAreaInsets.left
    
    if page >= book.pageCount {
      navigationController?.popViewController(animated: true)
    }
    currentPage = max(page, 0)
      
    let contentOffset = CGFloat(currentPage) * width - offset
    collectionView.setContentOffset(CGPoint(x: contentOffset, y: collectionView.contentOffset.y), animated: true)
    playAudio(for: currentPage)
  }
  
  @objc func nextPage() {
    start(at: currentPage + 1)
  }
  
  @objc func previousPage() {
    start(at: currentPage - 1)
  }
}

extension BookPlayViewController: AVAudioPlayerDelegate {
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    start(at: currentPage + 1)
  }
}
