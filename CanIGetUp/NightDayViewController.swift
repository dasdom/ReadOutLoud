//  Created by dasdom on 18.09.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import UIKit

class NightDayViewController: UIViewController {
  
  var timer: Timer?
  var timeSettings: [TimeSetting] = []
  
  var contentView: NightDayView {
    return view as! NightDayView
  }
  
  override func loadView() {
    let contentView = NightDayView(frame: UIScreen.main.bounds)
    
    contentView.rabbitButton.addTarget(self, action: #selector(openMusic), for: .touchUpInside)
    contentView.booksButton.addTarget(self, action: #selector(openBooks), for: .touchUpInside)

    view = contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settings(sender:)))
    
    timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateView), userInfo: nil, repeats: true)
    
    loadTimeSettings()
    updateView()
    
//    UIScreen.main.brightness = 0.1
    
    NotificationCenter.default.addObserver(self, selector: #selector(updateButton), name: hideButtonChangeNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(loadTimeSettings), name: timeSettingChangeNotification, object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    contentView.rabbitButton.isHidden = UserDefaults.standard.bool(forKey: hideRabbitButtonKey)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    updateView()
  }
  
  @objc func settings(sender: UIBarButtonItem) {
    
    let alert = UIAlertController(title: "Access control", message: "Answer to the Ultimate Question of Life, The Universe, and Everything\n(Let blank for cancel)", preferredStyle: .alert)
    alert.addTextField()
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
      if let textField = alert.textFields?.first, textField.text == "42" || textField.text == "fourty two" {
        let next = UINavigationController(rootViewController: SettingsTableViewController())
        self.present(next, animated: true)
      }
    }))
    present(alert, animated: true)
  }
  
  @objc func updateView() {
    
    if let start = timeSettings.first, let end = timeSettings.last {
      let timePeriod = TimePeriod(date: Date(), start: start.time, end: end.time)
      switch timePeriod {
      case .day:
        contentView.imageView.image = UIImage(named: "day")
      case .night:
        contentView.imageView.image = UIImage(named: "night")
      }
    }
  }
  
  @objc func openMusic() {
    UIApplication.shared.open(URL(string: "music://")!, options: [:], completionHandler: nil)
  }
  
  @objc func openBooks() {
    let next = BooksCollectionViewController()
    navigationController?.pushViewController(next, animated: true)
  }
  
  @objc func updateButton() {
    contentView.rabbitButton.isHidden = UserDefaults.standard.bool(forKey: hideRabbitButtonKey)
    contentView.booksButton.isHidden = UserDefaults.standard.bool(forKey: hideBooksButtonKey)
  }
  
  @objc func loadTimeSettings() {
    do {
      let url = FileManager.default.settingsPath()
      let data = try Data(contentsOf: url)
      timeSettings = try JSONDecoder().decode([TimeSetting].self, from: data)
    } catch {
      timeSettings = [TimeSetting(name: "Beginning of night", time: Time(hour: 19, minute: 0)),
                      TimeSetting(name: "End of night", time: Time(hour: 7, minute: 0))]
    }
  }
}
