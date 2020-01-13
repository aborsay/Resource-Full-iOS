//
//  ViewController.swift
//  Resource-Full
//
//  Created by Aaron Borsay on 8/8/19.
//  Copyright © 2019 Monetti. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var familyIcon: UIButton!
    @IBOutlet weak var educationIcon: UIButton!
    @IBOutlet weak var legalIcon: UIButton!
    
    @IBOutlet weak var houseIcon: UIButton!
    @IBOutlet weak var workerIcon: UIButton!
    @IBOutlet weak var foodIcon: UIButton!
    
    @IBOutlet weak var healthIcon: UIButton!
    @IBOutlet weak var transportationIcon: UIButton!
    @IBOutlet weak var moneyIcon: UIButton!
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchIcon: UIButton!
    @IBOutlet weak var infoIcon: UIButton!
    @IBOutlet weak var clothingIcon: UIButton!
    var categoryCurrent : Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //var dinner = UIImage(named: "dinner")
        searchText.delegate = self
        searchText.text = ""
        
        searchIcon.imageView!.contentMode = .scaleAspectFit

        familyIcon.imageView!.contentMode = .scaleAspectFit
        legalIcon.imageView!.contentMode = .scaleAspectFit
        educationIcon.imageView!.contentMode = .scaleAspectFit
        
        houseIcon.imageView!.contentMode = .scaleAspectFit
        workerIcon.imageView!.contentMode = .scaleAspectFit
        foodIcon.imageView!.contentMode = .scaleAspectFit
        
        healthIcon.imageView!.contentMode = .scaleAspectFit
        transportationIcon.imageView!.contentMode = .scaleAspectFit
        moneyIcon.imageView!.contentMode = .scaleAspectFit
        
        infoIcon.imageView!.contentMode = .scaleAspectFit
        clothingIcon.imageView!.contentMode = .scaleAspectFit
    }


 
    @IBAction func familyClickedForReal(_ sender: UIButton) {
        categoryCurrent = sender.tag
        if categoryCurrent == 0 && searchText.text == ""{
            return
        }
        let vc = ContactsController(nibName: "ContactsController", bundle: nil )
         vc.categoryCurrent = categoryCurrent
        
        print(String(categoryCurrent))
        performSegue(withIdentifier: "MovingProving", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "MovingProving"{
            let vc = segue.destination as! ContactsController
            if let button = sender as? UIButton{
                vc.categoryCurrent = button.tag
                if vc.categoryCurrent == 0{
                    vc.searchText =  searchText.text ?? ""
                }
            }
        }
    }
    /**/func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.resignFirstResponder()
        return true
    }
    
    @IBAction func gotoInfo(_ sender: UIButton) {
        print("info")
        performSegue(withIdentifier: "InfoMoving", sender: self)
    }
    
    @IBOutlet weak var family: UIImageView!
    
}

