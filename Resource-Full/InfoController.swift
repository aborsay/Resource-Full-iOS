//
//  InfoController.swift
//  Resource-Full
//
//  Created by user154345 on 9/29/19.
//  Copyright © 2019 Monetti. All rights reserved.
//

import UIKit

class InfoController: UIViewController {

  
    @IBOutlet weak var goBackButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Info")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     */
    @IBAction func goBack(_ sender: Any) {
         dismiss(animated: true, completion: nil)
     }
    
}
