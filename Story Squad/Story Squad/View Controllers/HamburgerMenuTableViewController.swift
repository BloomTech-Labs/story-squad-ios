//
//  HamburgerMenuTableViewController.swift
//  Story Squad
//
//  Created by macbook on 2/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class HamburgerMenuTableViewController: UITableViewController {
    
    var menuOptionTapped: ((HamburgerMenuOptions) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chosenMenuOption = HamburgerMenuOptions(rawValue: indexPath.row) else { return }
        dismiss(animated: true) {
            self.menuOptionTapped?(chosenMenuOption)
        }
    }
}
