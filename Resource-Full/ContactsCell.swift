//
//  ContactsInfoTableViewCell.swift
//  Resource-Full
//
//  Created by user154345 on 9/30/19.
//  Copyright © 2019 Monetti. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {

    @IBOutlet weak var FullName: UILabel!
    
    @IBOutlet weak var Organization: UILabel!
    @IBOutlet weak var Phone1: UILabel!
    @IBOutlet weak var Phone2: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Address: UILabel!
    
    
    func setContact(contact: Contacts){
        FullName.text = contact.contactFullname ?? ""
        Organization.text = contact.contactOrganization ?? ""
        Phone1.text = contact.contactPhone ?? ""
        Address.text = contact.contactAddress ?? ""
        Phone2.text = contact.contact2ndPhone ?? ""
        Email.text = contact.contactEmail ?? ""
    }

    
}
