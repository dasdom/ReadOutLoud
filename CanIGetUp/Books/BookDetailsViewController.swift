//  Created by dasdom on 01.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {
  
  private var saveButton: UIBarButtonItem?
  private var contentView: BookDetailsView {
    return view as! BookDetailsView
  }
  
  override func loadView() {
    let contentView = BookDetailsView()
    view = contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Add Book"
    
    saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save(_:)))
    navigationItem.rightBarButtonItem = saveButton
    saveButton?.isEnabled = false
    
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(dismiss(_:)))
    navigationItem.leftBarButtonItem = cancelButton
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    contentView.stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension BookDetailsViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    guard let text = textField.text else {
      return true
    }
    let nsText = text as NSString
    let finalText = nsText.replacingCharacters(in: range, with: string)
    
    let title: String?
    let author: String?
    if textField == contentView.titleTextField {
      title = finalText
      author = contentView.authorTextField.text
    } else if textField == contentView.authorTextField {
      title = contentView.titleTextField.text
      author = finalText
    } else {
      title = nil
      author = nil
    }
    
    if let title = title, let author = author, !title.isEmpty, !author.isEmpty {
      saveButton?.isEnabled = true
    } else {
      saveButton?.isEnabled = false
    }
    
    return true
  }
}

// MARK: - Actions
extension BookDetailsViewController {
  @objc func save(_ sender: UIBarButtonItem) {
    
  }
  
  @objc func dismiss(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
  }
}
