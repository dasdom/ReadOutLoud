//  Created by dasdom on 01.01.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {
  
  private var saveButton: UIBarButtonItem?
  var contentView: BookDetailsView {
    return view as! BookDetailsView
  }
  private var titleTextField: UITextField {
    return contentView.titleTextField
  }

  private let addCompletion: (Book) -> Void
  
  init(addCompletion: @escaping (Book) -> Void) {
    
    self.addCompletion = addCompletion
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func loadView() {
    let contentView = BookDetailsView()
    
    contentView.addImageButton.addTarget(self, action: #selector(addImage(_:)), for: .touchUpInside)
    
    contentView.titleTextField.delegate = self
    
    view = contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Add Book"
    
    saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    navigationItem.rightBarButtonItem = saveButton
    saveButton?.isEnabled = false
    
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismiss(_:)))
    navigationItem.leftBarButtonItem = cancelButton
    
  }
}

// MARK: - Actions
extension BookDetailsViewController {
  @objc func save() {
    guard let title = titleTextField.text, false == title.isEmpty else {
      return
    }
    
    let book = Book(title: title)
    
    FileManager.default.createBooksDiretory(for: book)
    guard let image = contentView.coverImageView.image, let data = image.jpegData(compressionQuality: 0.3) else {
      return
    }
    do {
      try data.write(to: FileManager.default.bookCoverURL(for: book))
    } catch {
      print("error: \(error)")
    }
    
    addCompletion(book)
    dismiss(animated: true)
  }
  
  @objc func dismiss(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
  }
  
  @objc func addImage(_ sender: UIButton) {
    let imagePicker = UIImagePickerController()
    #if targetEnvironment(simulator)
    imagePicker.sourceType = .photoLibrary
    #else
    imagePicker.sourceType = .camera
    #endif
    imagePicker.delegate = self
    present(imagePicker, animated: true)
  }
}

extension BookDetailsViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    guard let text = textField.text else {
      return true
    }
    let nsText = text as NSString
    let finalText = nsText.replacingCharacters(in: range, with: string)
    
    updateSaveButton(title: finalText)
    
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
  
  func updateSaveButton(title: String?) {
    if let title = title, !title.isEmpty,
       contentView.coverImageView.image != nil {
      saveButton?.isEnabled = true
    } else {
      saveButton?.isEnabled = false
    }
  }
}

extension BookDetailsViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    dismiss(animated: true)
        
    contentView.coverImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    
    updateSaveButton(title: titleTextField.text)
  }
}

