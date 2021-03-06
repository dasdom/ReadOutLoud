//  Created by dasdom on 18.09.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import UIKit

let hideRabbitButtonKey = "hideRabbitButtonKey"
let hideBooksButtonKey = "hideBooksButtonKey"
let hideButtonChangeNotification = Notification.Name(rawValue: "hideButtonChangeNotification")
let timeSettingChangeNotification = Notification.Name(rawValue: "timeSettingChangeNotification")

enum SettingsSection : Int, CaseIterable {
  case books
  case time
  case credits
  case misc
}

enum MiscRow : Int, CaseIterable {
  case showRabbitButton
//  case showBooksButton
  case about
}

class SettingsTableViewController: UITableViewController {
  
  var hideRabbitButton = UserDefaults.standard.bool(forKey: hideRabbitButtonKey) {
    didSet {
      UserDefaults.standard.set(hideRabbitButton, forKey: hideRabbitButtonKey)
      NotificationCenter.default.post(name: hideButtonChangeNotification, object: self)
    }
  }
  var hideBooksButton = UserDefaults.standard.bool(forKey: hideBooksButtonKey) {
    didSet {
      UserDefaults.standard.set(hideBooksButton, forKey: hideBooksButtonKey)
      NotificationCenter.default.post(name: hideButtonChangeNotification, object: self)
    }
  }
  var timeSettings : [TimeSetting] = {
    let tempTimeSettings: [TimeSetting]
    do {
      let url = FileManager.default.settingsPath()
      let data = try Data(contentsOf: url)
      tempTimeSettings = try JSONDecoder().decode([TimeSetting].self, from: data)
    } catch {
      print("error: \(error)")

      tempTimeSettings = [TimeSetting(name: "Beginning of night", time: Time(hour: 19, minute: 0)),
                          TimeSetting(name: "End of night", time: Time(hour: 7, minute: 0))]
    }
    return tempTimeSettings
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 44
    tableView.rowHeight = UITableView.automaticDimension
    
    tableView.register(SettingsTimeTableViewCell.self, forCellReuseIdentifier: SettingsTimeTableViewCell.identifier)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Basic")

    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    
    title = "Settings"
  }
  
  @objc func done() {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - UITableViewDataSource
extension SettingsTableViewController {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return SettingsSection.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    guard let settingsSection = SettingsSection(rawValue: section) else {
      return 0
    }
    
    let numberOfRows: Int
    
    switch settingsSection {
      case .books:
        numberOfRows = 1
      case .time:
        numberOfRows = timeSettings.count
      case .credits:
        numberOfRows = 1
      case .misc:
        numberOfRows = MiscRow.allCases.count
    }
    
    return numberOfRows
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let settingsSection = SettingsSection(rawValue: indexPath.section) else {
      return UITableViewCell()
    }
    
    let cell: UITableViewCell
    
    switch settingsSection {
      
      case .books:
        
        cell = tableView.dequeueReusableCell(withIdentifier: "Basic", for: indexPath)
        cell.textLabel?.text = "Books"
        cell.accessoryType = .disclosureIndicator
      
      case .time:
        
        let timeCell = tableView.dequeueReusableCell(withIdentifier: SettingsTimeTableViewCell.identifier, for: indexPath) as! SettingsTimeTableViewCell
        
        let timeSetting = timeSettings[indexPath.row]
        timeCell.update(timeSetting: timeSetting) { date, error in
          if let date = date {
            timeSetting.time = Time(date: date)
            self.writeTimeSettings()
            tableView.reloadRows(at: [indexPath], with: .none)
          }
        }
        cell = timeCell
        
      case .credits:
        
        cell = tableView.dequeueReusableCell(withIdentifier: "Basic", for: indexPath)
        cell.textLabel?.text = "Images"
        cell.accessoryType = .disclosureIndicator
        
      case .misc:
        
        guard let miscRow = MiscRow(rawValue: indexPath.row) else {
          return UITableViewCell()
        }
        
        switch miscRow {
          case .showRabbitButton:
            cell = tableView.dequeueReusableCell(withIdentifier: "Basic", for: indexPath)
            cell.textLabel?.text = "Show rabbit button"
            if hideRabbitButton {
              cell.accessoryType = .none
            } else {
              cell.accessoryType = .checkmark
            }
//          case .showBooksButton:
//            cell = tableView.dequeueReusableCell(withIdentifier: "Basic", for: indexPath)
//            cell.textLabel?.text = "Show books button"
//            if hideBooksButton {
//              cell.accessoryType = .none
//            } else {
//              cell.accessoryType = .checkmark
//            }
          case .about:
            cell = tableView.dequeueReusableCell(withIdentifier: "Basic", for: indexPath)
            cell.textLabel?.text = "About"
            cell.accessoryType = .disclosureIndicator
        }
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    guard let settingsSection = SettingsSection(rawValue: section) else {
      return nil
    }
    
    let title: String
    
    switch settingsSection {
      case .books:
        title = "Add books"
      case .time:
        title = "Night Mode Times"
      case .credits:
        title = "Credits"
      case .misc:
        title = "Misc"
    }
    
    return title
  }
}

// MARK: - UITableViewDelegate
extension SettingsTableViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let settingsSection = SettingsSection(rawValue: indexPath.section) else {
      return
    }
    
    switch settingsSection {
      
      case .books:
        let next = BooksCollectionViewController()
        next.isEditing = true
        navigationController?.pushViewController(next, animated: true)
      
      case .time:
        let timeSetting = timeSettings[indexPath.row]
        timeSetting.expanded = !timeSetting.expanded
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
      case .credits:
        let next = ImageCreditsTableViewController()
        navigationController?.pushViewController(next, animated: true)
        
      case .misc:
        
        guard let miscRow = MiscRow(rawValue: indexPath.row) else {
          return
        }
        
        switch miscRow {
          case .showRabbitButton:
            hideRabbitButton = !hideRabbitButton
            tableView.reloadRows(at: [indexPath], with: .automatic)
//          case .showBooksButton:
//            hideBooksButton = !hideBooksButton
//            tableView.reloadRows(at: [indexPath], with: .automatic)
          case .about:
            let next = AboutTableViewController()
            navigationController?.pushViewController(next, animated: true)
        }
    }
  }
  
  func writeTimeSettings() {
    do {
      let url = FileManager.default.settingsPath()
      let data = try JSONEncoder().encode(timeSettings)
      try data.write(to: url)
      NotificationCenter.default.post(name: timeSettingChangeNotification, object: self)
      print("did write times")
    } catch {
      print("error: \(error)")
    }
  }
}
