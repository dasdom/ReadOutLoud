//  Created by Dominik Hauser on 26/02/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class AboutTableViewControllerTests: XCTestCase {
  
  var sut: AboutTableViewController!
  
  override func setUpWithError() throws {
    sut = AboutTableViewController()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_loadingView_registersAboutCell() throws {
    sut.loadViewIfNeeded()
    
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: AboutCell.identifier, for: indexPath)
    
    XCTAssertTrue(cell is AboutCell)
  }
  
  func test_numberOfRows() throws {
    
    let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
    
    XCTAssertEqual(numberOfRows, 5)
  }
  
  func test_cellForRow_returnsAboutCell() throws {
    
    let indexPath = IndexPath(row: 0, section: 0)
    let dataSource = sut.tableView.dataSource
    let cell = dataSource?.tableView(sut.tableView, cellForRowAt: indexPath) as? AboutCell
    
    let unwrappedCell = try XCTUnwrap(cell)
    let aboutItem = try XCTUnwrap(sut.aboutItems.first)
    XCTAssertEqual(unwrappedCell.headlineLabel.text, aboutItem.headline)
    XCTAssertEqual(unwrappedCell.headlineLabel.text, aboutItem.headline)
  }
}
