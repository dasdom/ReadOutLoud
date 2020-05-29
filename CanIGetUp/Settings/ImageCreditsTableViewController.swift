//  Created by dasdom on 10.04.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

class ImageCreditsTableViewController: UITableViewController {
  
  let imageCredits = [
    ImageCredit(imageName: "day", creditText: "Photo by Gustavo Quepón on Unsplash"),
    ImageCredit(imageName: "night", creditText: "Photo by eberhard grossgasteiger on Unsplash"),
    ImageCredit(imageName: "rabbit", creditText: "Photo by Emiliano Vittoriosi on Unsplash"),
    ImageCredit(imageName: "books", creditText: "Photo by Alfons Morales on Unsplash"),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(ImageCreditCell.self, forCellReuseIdentifier: ImageCreditCell.identifier)
    tableView.rowHeight = 100
    
    title = "Credits"
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return imageCredits.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: ImageCreditCell.identifier, for: indexPath) as! ImageCreditCell
    
    let imageCredit = imageCredits[indexPath.row]
    cell.update(with: imageCredit)
    
    return cell
  }
}
