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

  init(book: Book) {
    
    self.book = book
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.sectionInset = .zero
    flowLayout.minimumInteritemSpacing = 0
    flowLayout.minimumLineSpacing = 0
    
    super.init(collectionViewLayout: flowLayout)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: PageCollectionViewCell.identifier)
    
    collectionView?.isPagingEnabled = true
    collectionView?.isScrollEnabled = false
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    playAudio(for: 0)
    
    UIApplication.shared.isIdleTimerDisabled = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    UIApplication.shared.isIdleTimerDisabled = false
  }
  
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    let contentOffset = CGFloat(currentPage) * size.width
    collectionView.setContentOffset(CGPoint(x: contentOffset, y: collectionView.contentOffset.y), animated: true)
    collectionView.collectionViewLayout.invalidateLayout()
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
    print("page: \(index)")
    guard let url = book.pageAudioURL(index: index) else {
      return
    }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback)
      player = try AVAudioPlayer(contentsOf: url)
      player?.delegate = self
      player?.play()
    } catch {
      print("error: \(error)")
    }
  }
  
}

extension BookPlayViewController: AVAudioPlayerDelegate {
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    let width = collectionView.contentSize.width / CGFloat(book.pageCount) //collectionView.frame.inset(by: collectionView.safeAreaInsets).size.width
    let offset = collectionView.safeAreaInsets.left
//    let pageIndex = Int(collectionView.contentOffset.x / (width - offset))
    currentPage = currentPage + 1
    if currentPage >= book.pageCount {
      navigationController?.popViewController(animated: true)
    }
    let contentOffset = CGFloat(currentPage) * width - offset
    collectionView.setContentOffset(CGPoint(x: contentOffset, y: collectionView.contentOffset.y), animated: true)
    playAudio(for: currentPage)
  }
}
