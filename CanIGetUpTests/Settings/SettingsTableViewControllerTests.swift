//  Created by Dominik Hauser on 26/02/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class SettingsTableViewControllerTests: XCTestCase {
  
  var sut: SettingsTableViewController!
  
  override func setUpWithError() throws {
    sut = SettingsTableViewController()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_loadingView_registersSettingsTimeTableViewCell() throws {
    
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView.dequeueReusableCell(withIdentifier: SettingsTimeTableViewCell.identifier, for: indexPath)
    
    XCTAssertTrue(cell is SettingsTimeTableViewCell)
  }
  
  func test_loadingView_registersBasicCell() throws {
    
    let indexPath = IndexPath(row: 0, section: 0)
    _ = sut.tableView.dequeueReusableCell(withIdentifier: "Basic", for: indexPath)
  }
  
  func test_doneButton_dismissesSut() throws {
    
    sut = SpySettingsTableViewController()
    _ = MockNavigationController(rootViewController: sut)
    sut.loadViewIfNeeded()
    
    let navigationItem = try XCTUnwrap(sut.navigationItem.rightBarButtonItem)
    try navigationItem.performAction()
    
    let spy = try XCTUnwrap(sut as? SpySettingsTableViewController)
    XCTAssertEqual(spy.dismissCallCount, 1)
  }
  
  func test_numberOfSections() {
    
    XCTAssertEqual(sut.tableView.numberOfSections, 4)
  }
  
  func test_numberOfRows_books() {
   
    let numberOfRows = sut.tableView.numberOfRows(inSection: SettingsSection.books.rawValue)
    
    XCTAssertEqual(numberOfRows, 1)
  }
  
  func test_numberOrRows_time() {
    
    let numberOfRows = sut.tableView.numberOfRows(inSection: SettingsSection.time.rawValue)
    
    XCTAssertEqual(numberOfRows, 2)
  }
  
  func test_numberOrRows_credits() {
    
    let numberOfRows = sut.tableView.numberOfRows(inSection: SettingsSection.credits.rawValue)
    
    XCTAssertEqual(numberOfRows, 1)
  }
  
  func test_numberOrRows_misc() {
    
    let numberOfRows = sut.tableView.numberOfRows(inSection: SettingsSection.misc.rawValue)
    
    XCTAssertEqual(numberOfRows, 2)
  }
  
  func test_cellForRow_books() throws {
    
    let indexPath = IndexPath(row: 0, section: SettingsSection.books.rawValue)
    let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
    
    XCTAssertEqual(cell?.textLabel?.text, "Books")
  }
  
  func test_cellForRow_timeSetting() throws {
    
    let indexPath = IndexPath(row: 0, section: SettingsSection.time.rawValue)
    let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath) as? SettingsTimeTableViewCell
    
    let timeSetting = try XCTUnwrap(sut.timeSettings.first)
    XCTAssertEqual(cell?.nameLabel.text, timeSetting.name)
    XCTAssertEqual(cell?.timeLabel.text, timeSetting.time.string)
  }
  
  func test_cellForRow_credits() throws {
    
    let indexPath = IndexPath(row: 0, section: SettingsSection.credits.rawValue)
    let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
    
    XCTAssertEqual(cell?.textLabel?.text, "Images")
  }
  
  func test_cellForRow_rabbit() throws {
    
    let indexPath = IndexPath(row: MiscRow.showRabbitButton.rawValue, section: SettingsSection.misc.rawValue)
    let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
    
    XCTAssertEqual(cell?.textLabel?.text, "Show rabbit button")
  }
  
  func test_cellForRow_about() throws {
    
    let indexPath = IndexPath(row: MiscRow.about.rawValue, section: SettingsSection.misc.rawValue)
    let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
    
    XCTAssertEqual(cell?.textLabel?.text, "About")
  }
  
  func test_didSelect_books() {
    
    let mockNavigationController = MockNavigationController(rootViewController: sut)
    
    let indexPath = IndexPath(row: 0, section: SettingsSection.books.rawValue)
    sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)
    
    XCTAssertTrue(mockNavigationController.pushedViewController is BooksCollectionViewController)
  }
  
  func test_didSelect_time() throws {
    
    let indexPath = IndexPath(row: 0, section: SettingsSection.time.rawValue)
    sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)

    let timeSetting = try XCTUnwrap(sut.timeSettings.first)
    XCTAssertEqual(timeSetting.expanded, true)
  }
  
  func test_didSelect_credits() {
    
    let mockNavigationController = MockNavigationController(rootViewController: sut)
    
    let indexPath = IndexPath(row: 0, section: SettingsSection.credits.rawValue)
    sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)
    
    XCTAssertTrue(mockNavigationController.pushedViewController is ImageCreditsTableViewController)
  }
  
  func test_didSelect_rabbit() throws {
    
    let previousHideRabbitButton = sut.hideRabbitButton
    
    let indexPath = IndexPath(row: MiscRow.showRabbitButton.rawValue, section: SettingsSection.misc.rawValue)
    sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)

    XCTAssertNotEqual(sut.hideRabbitButton, previousHideRabbitButton)
  }
  
  func test_didSelect_about() {
    
    let mockNavigationController = MockNavigationController(rootViewController: sut)
    
    let indexPath = IndexPath(row: MiscRow.about.rawValue, section: SettingsSection.misc.rawValue)
    sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)
    
    XCTAssertTrue(mockNavigationController.pushedViewController is AboutTableViewController)
  }
  
  func test_timeSettingChange_sendsNotification() throws {
    
    let expectNotification = expectation(forNotification: timeSettingChangeNotification, object: nil, handler: nil)
    
    let indexPath = IndexPath(row: 0, section: SettingsSection.time.rawValue)
    let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath) as? SettingsTimeTableViewCell
    cell?.updateHandler?(Date(), nil)
    
    wait(for: [expectNotification], timeout: 1)
  }
}
