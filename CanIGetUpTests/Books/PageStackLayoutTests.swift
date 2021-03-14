//  Created by Dominik Hauser on 14/03/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class PageStackLayoutTests: XCTestCase {
  
  var sut: PageStackLayout!
  
  override func setUpWithError() throws {
    sut = PageStackLayout()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_collectionViewContentSize() {
    let width = 200
    let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: 100), collectionViewLayout: sut)
    let dataSource = StubCollectionViewDataSource()
    collectionView.dataSource = dataSource
    
    let contentSize = sut.collectionViewContentSize
    
    XCTAssertEqual(contentSize, CGSize(width: 3 * width, height: 100))
  }
  
  func test_layoutAttributesForElements_previousElement() throws {
    let width = 200
    let height = 100
    let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: sut)
    let dataSource = StubCollectionViewDataSource()
    collectionView.dataSource = dataSource
    
    let previousElementAttributes = try XCTUnwrap(sut.layoutAttributesForElements(in: CGRect(x: 10, y: 0, width: width, height: height))?.first)
    
    XCTAssertEqual(previousElementAttributes.frame, CGRect(x: 0, y: 0, width: 200, height: 100))
  }
  
  func test_layoutAttributesForElements_currentElement() throws {
    let width = 200
    let height = 100
    let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: sut)
    let dataSource = StubCollectionViewDataSource()
    collectionView.dataSource = dataSource
    
    let currentElementAttributes = try XCTUnwrap(sut.layoutAttributesForElements(in: CGRect(x: 10, y: 0, width: width, height: height)))[1]
    
    XCTAssertEqual(currentElementAttributes.frame, CGRect(x: 10, y: 5, width: 180, height: 90))
  }
}

extension PageStackLayoutTests {
  class StubCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      return UICollectionViewCell()
    }
  }
}
