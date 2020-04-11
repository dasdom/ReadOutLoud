//  Created by dasdom on 10.04.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {
  
  let aboutItems = [
    AboutItem(headline: "What is this?", body: "Put that app on the iPhone or iPad your child uses. Then set the time when the night begins and when it ends. During the night the app shows a night sky. During the day it shows a field of sun flowers. So your child knows when it's ok to get up without waking you up."),
    AboutItem(headline: "Why is it free?", body: "I build it for myself. It helped me a lot. So I thought it might help other parents as well. I don't want to make money with it."),
    AboutItem(headline: "Is it safe?", body: "This app doesn't collect any data. It also doesn't communicate with any server at all. It's quite simple. It just shows images depending on the time. So I would say, it is safe."),
    AboutItem(headline: "Who made this?", body: "My name is Dominik. I'm an iOS developer from Germany. You can email me to dominik.hauser@dasdom.de. If this app helps you getting more sleep, I'd love to read about that."),
    AboutItem(headline: "Rabbit button", body: "The rabbit button opens Apple Music. You can hide the button in the settings. I plan to add a setting to open Spotify from that button.")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(AboutCell.self, forCellReuseIdentifier: AboutCell.identifier)
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return aboutItems.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.identifier, for: indexPath) as! AboutCell
    
    let aboutItem = aboutItems[indexPath.row]
    cell.update(with: aboutItem)
    
    return cell
  }
  
}
