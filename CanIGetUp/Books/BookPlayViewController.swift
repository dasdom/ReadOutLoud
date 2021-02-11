//  Created by dasdom on 10.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "Cell"

class BookPlayViewController: UICollectionViewController {
  
  let book: Book
  private var player: AVAudioPlayer?

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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.itemSize = collectionView.frame
        .inset(by: collectionView.contentInset)
        .inset(by: UIEdgeInsets(top: navigationController?.navigationBar.frame.maxY ?? 0, left: 0, bottom: 40, right: 0))
        .size
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    playAudio(for: 0)
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
  
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
    playAudio(for: pageIndex)
  }
  
  func playAudio(for index: Int) {
    print("page: \(index)")
    guard let url = book.pageAudioURL(index: index) else {
      return
    }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback)
      player = try AVAudioPlayer(contentsOf: url)
//      player?.delegate = self
      player?.play()
    } catch {
      print("error: \(error)")
    }
  }
}
