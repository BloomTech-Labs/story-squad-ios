//
//  DashboardViewController.swift
//  Story Squad
//
//  Created by macbook on 2/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        updateViews()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var storySquadLabel: UILabel!
    
    func updateViews() {
        storySquadLabel.textColor.setStroke()
        setStrokePumpkin()
    }

    func setStrokePumpkin() {
        pumpkinColor.setStroke()
    }
    
    //Red: 0, green: 0.447, blue: 0.733, alpha: 1)
    let pumpkinColor = UIColor(displayP3Red: 1, green: 0.427, blue: 0.227, alpha: 1)
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
