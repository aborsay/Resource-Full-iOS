//
//  ContactsController.swift
//  Resource-Full
//
//  Created by user154345 on 9/29/19.
//  Copyright © 2019 Monetti. All rights reserved.
//

import UIKit
import SQLite3

class ContactsController: UIViewController {

    var categoryCurrent : Int = 11
    var searchText : String = ""
    var db: OpaquePointer?
    var dbOpen : Bool = true
    var contactList = [Contacts]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var id : Int32 = 0
    var contact_id  : Int32 = 1
    var contact_name_prefix  : Int32 = 3
    var contact_name_first  : Int32 = 4
    var contact_name_middle  : Int32 = 5
    var contact_name_last  : Int32 = 6
    var contact_name_suffix  : Int32 = 7
    var contact_organization  : Int32 = 8
    var contact_position  : Int32 = 9
    var contact_address  : Int32 = 10
    var contact_subaddres  : Int32 = 11
    var contact_city  : Int32 = 12
    var contact_state  : Int32 = 13
    var contact_postalcode  : Int32 = 14
    var contact_phone  : Int32 = 15
    var contact_2nd_phone  : Int32 = 16
    var contact_fax  : Int32 = 17
    var contact_email  : Int32 = 18
    var contact_web_url  : Int32 = 19
    
    
    
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categorySub: UILabel!
    @IBOutlet weak var categoryType: UILabel!
    
    //var catagoryClicked :
    @IBOutlet weak var goBackButton: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
     
        goBackButton.imageView!.contentMode = .scaleAspectFit
        let dbPath = Bundle.main.resourceURL?.appendingPathComponent("resource_full.sqlite")
        if sqlite3_open(dbPath?.path, &db) != SQLITE_OK {
            print("Error Opening")
            dbOpen = false
        }else{
            print("DB Opened")
            dbOpen = true
            categoryHeader()
            createList()
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    func tapFunction(sender: UITapGestureRecognizer){
        print("tap")
    }
    
    /*
     happensright when screen opens
     */
    override func viewWillAppear(_ animated: Bool) {
        if !dbOpen {
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
          }
    }
    
    /*
     Create List for display
     */
     
    func createList(){
        
        contactList.removeAll()
        var categoryCurrentString :String = String(categoryCurrent)
        if categoryCurrentString.count == 1 {
            categoryCurrentString = "0" + categoryCurrentString
        }
        print("Cat: \(categoryCurrentString)")
        var  queryString : String
        
        if categoryCurrent == 0 {
            queryString = """
            SELECT (SELECT COUNT(contact_id) as count
            FROM contacts
            WHERE contact_name_last LIKE "%\(searchText)%"
            OR contact_name_first LIKE "%\(searchText)%"
            OR contact_organization LIKE "%\(searchText)%") as count,
            contacts.*
            FROM contacts
            WHERE contact_name_last LIKE "%\(searchText)%"
            OR contact_name_first LIKE "%\(searchText)%"
            OR contact_organization LIKE "%\(searchText)%"
            ORDER BY contact_name_last ASC, contact_name_first ASC, contact_organization ASC LIMIT 0,9999999999
            """
        }else{
            queryString = """
                    SELECT (SELECT COUNT(contact_id) as count
                    FROM contacts WHERE helpType1 LIKE "\(categoryCurrentString)|%" ) as count,contacts.*
                    FROM contacts WHERE helpType1 LIKE "\(categoryCurrentString)|%"
                    ORDER BY contact_name_last ASC, contact_name_first ASC, contact_organization ASC LIMIT 0,9999999
                    """
        }
        print("Query: \(queryString)")
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
          
            
            
            let contactFullName = String(cString: sqlite3_column_text(stmt, contact_name_prefix))+" "+String(cString: sqlite3_column_text(stmt, contact_name_first))+" "+String(cString: sqlite3_column_text(stmt, contact_name_middle))+" "+String(cString: sqlite3_column_text(stmt, contact_name_last))+" "+String(cString: sqlite3_column_text(stmt, contact_name_suffix))
            let contactID = String(cString: sqlite3_column_text(stmt, contact_id))
            let contactOrganization = String(cString: sqlite3_column_text(stmt, contact_organization))
            let contactPhone = String(cString: sqlite3_column_text(stmt, contact_phone))
            let contact2ndPhone = String(cString: sqlite3_column_text(stmt, contact_2nd_phone))
            let contactEmail = String(cString: sqlite3_column_text(stmt, contact_email))
            var contactAddress = String(cString: sqlite3_column_text(stmt, contact_address))
            let contactSubAddress = String(cString: sqlite3_column_text(stmt, contact_subaddres))
            let contactCity = String(cString: sqlite3_column_text(stmt, contact_city))
            let contactState = String(cString: sqlite3_column_text(stmt, contact_state))
            let contactPostalCode = String(cString: sqlite3_column_text(stmt, contact_postalcode))
            let contactWebURL = String(cString: sqlite3_column_text(stmt, contact_web_url))
            if !contactSubAddress.isEmpty {
                contactAddress += ", "+contactSubAddress
            }
            contactAddress += "\n"
            if !contactCity.isEmpty {
                contactAddress += contactCity
            }
            
            if !contactState.isEmpty {
                if !contactCity.isEmpty {
                    contactAddress += ", "
                }
                contactAddress += contactState
            }
            
            if !contactPostalCode.isEmpty {
                contactAddress += " " + contactPostalCode
            }
          
            contactList.append(Contacts(contactID: Int(contactID) ?? 0, contactFullname: contactFullName, contactOrganization: contactOrganization, contactPhone: contactPhone, contact2ndPhone: contact2ndPhone, contactEmail: contactEmail, contactAddress: contactAddress, contactPostalCode: contactPostalCode, contactWebURL: contactWebURL))
        }
      
    }
    
    func categoryHeader(){
 
        print(String(categoryCurrent))
        categorySub.text = ""
        switch categoryCurrent
        {
            case 1:
                categoryType.text = "Family"
                categoryIcon.image = UIImage(named: "family")
            case 2:
                categoryType.text = "Legal"
                categoryIcon.image = UIImage(named: "legal")
            case 3:
                categoryType.text = "Education"
                categoryIcon.image = UIImage(named: "education")
            case 4:
                categoryType.text = "Housing"
                categoryIcon.image = UIImage(named: "housing")
            case 5:
                categoryType.text = "Work"
                categoryIcon.image = UIImage(named: "work")
            case 6:
                categoryType.text = "Food"
                categoryIcon.image = UIImage(named: "food")
            case 7:
                categoryType.text = "Health"
                categoryIcon.image = UIImage(named: "health")
            case 8:
                categoryType.text = "Transportation"
                categoryIcon.image = UIImage(named: "transportation")
            case 9:
                categoryType.text = "Finance"
                categoryIcon.image = UIImage(named: "finance")
            case 10:
                categoryType.text = "Clothing"
                categoryIcon.image = UIImage(named: "clothing")
            
            default:
                categoryType.text = "Search Text Below"
                categorySub.text = searchText
                categoryIcon.image = UIImage(named: "icons_search")
        }
    }
    


    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension ContactsController : UITableViewDataSource, UITableViewDelegate{
    //let cellSpacingHeight: CGFloat = 5
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = contactList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell") as! ContactsCell
        cell.setContact(contact: contact)
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        //cell.layoutSubviews()
        cell.clipsToBounds = true
        return cell
    }

}


