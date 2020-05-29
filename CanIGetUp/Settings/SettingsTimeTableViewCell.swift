//  Created by dasdom on 18.09.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import UIKit

class SettingsTimeTableViewCell: UITableViewCell {

  let nameLabel: UILabel
  let timeLabel: UILabel
  let datePicker: UIDatePicker
  var updateHandler: ((Date?,Error?) -> Void)?
  
  static var identifier: String {
    return NSStringFromClass(self)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    nameLabel = UILabel()
    timeLabel = UILabel()
    
    datePicker = UIDatePicker()
    datePicker.datePickerMode = .time
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)

    timeLabel.setContentHuggingPriority(.required, for: .horizontal)
    
    let labelStackViews = UIStackView(arrangedSubviews: [nameLabel, timeLabel])
    
    let stackView = UIStackView(arrangedSubviews: [labelStackViews, datePicker])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(timeSetting: TimeSetting, updateHandler: ((Date?,Error?) -> Void)?) {
    
    self.updateHandler = updateHandler
    
    nameLabel.text = timeSetting.name
    timeLabel.text = timeSetting.time.string
    
    datePicker.setDate(timeSetting.time.date, animated: false)
    
    datePicker.isHidden = !timeSetting.expanded
  }
  
  @objc func datePickerChanged(sender: UIDatePicker) {
    updateHandler?(sender.date, nil)
  }
}
