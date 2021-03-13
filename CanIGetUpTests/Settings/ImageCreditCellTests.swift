//  Created by Dominik Hauser on 13/03/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class ImageCreditCellTests: XCTestCase {
  
  var sut: ImageCreditCell!
  
  override func setUpWithError() throws {
    sut = ImageCreditCell()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }

  func test_identifier() {
    XCTAssertEqual(ImageCreditCell.identifier, "CanIGetUp.ImageCreditCell")
  }
  
  func test_init_addsCreditImageView() {
    XCTAssertTrue(sut.creditImageView.isDescendant(of: sut.contentView))
  }
  
  func test_init_addsNameLabel() {
    XCTAssertTrue(sut.nameLabel.isDescendant(of: sut.contentView))
  }
  
  func test_update_setsImage() {
    let imageCredit = ImageCredit(imageName: "day", creditText: "Foo")
    
    sut.update(with: imageCredit)
    
    XCTAssertNotNil(sut.creditImageView.image)
  }
  
  func test_update_setsName() {
    let imageCredit = ImageCredit(imageName: "day", creditText: "Foo")
    
    sut.update(with: imageCredit)
    
    XCTAssertEqual(sut.nameLabel.text, "Foo")
  }
}
