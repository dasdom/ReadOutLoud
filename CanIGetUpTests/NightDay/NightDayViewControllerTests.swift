//  Created by Dominik Hauser on 26/02/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import XCTest
@testable import CanIGetUp

class NightDayViewControllerTests: XCTestCase {
  
  var sut: NightDayViewController!
  
  override func setUpWithError() throws {
    sut = NightDayViewController()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_loadingView_setsNightDayView() throws {
    
    sut.loadViewIfNeeded()
    
    XCTAssertTrue(sut.view is NightDayView)
  }
  
  func test_appearingView_setsRabbitButtonHidden() throws {
    
    UserDefaults.standard.setValue(true, forKey: hideRabbitButtonKey)
    
    sut.beginAppearanceTransition(true, animated: false)
    sut.endAppearanceTransition()
    
    let nightDayView = try XCTUnwrap(sut.view as? NightDayView)
    XCTAssertEqual(nightDayView.rabbitButton.isHidden, true)
  }
  
  func test_appearingView_setsRabbitButtonVisible() throws {
    
    UserDefaults.standard.setValue(false, forKey: hideRabbitButtonKey)
    
    sut.beginAppearanceTransition(true, animated: false)
    sut.endAppearanceTransition()
    
    let nightDayView = try XCTUnwrap(sut.view as? NightDayView)
    XCTAssertEqual(nightDayView.rabbitButton.isHidden, false)
  }
  
  func test_settingsButton_presentsAlert() throws {
    
    UIApplication.shared.windows.first?.rootViewController = sut
    sut.loadViewIfNeeded()
    
    let settingsButton = try XCTUnwrap(sut.navigationItem.rightBarButtonItem)
    try settingsButton.performAction()
    
    XCTAssertTrue(sut.presentedViewController is UIAlertController)
  }
}
