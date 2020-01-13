//
//  Contacts.swift
//  Resource-Full
//
//  Created by user154345 on 9/30/19.
//  Copyright © 2019 Monetti. All rights reserved.
//

import Foundation

class Contacts{
    var contactID: Int
    var contactFullname: String?
    var contactOrganization: String?
    var contactPhone: String?
    var contact2ndPhone: String?
    var contactEmail: String?
    var contactAddress: String?
    var contactPostalCode: String?
    var contactWebURL: String?
    
    init(contactID: Int, contactFullname:String?,contactOrganization:String?, contactPhone:String?,contact2ndPhone:String?,contactEmail:String?, contactAddress:String?,contactPostalCode:String?,contactWebURL:String?) {
        self.contactID = contactID
        self.contactFullname = contactFullname
        self.contactOrganization = contactOrganization
        self.contactPhone = contactPhone
        self.contact2ndPhone = contact2ndPhone
        self.contactEmail = contactEmail
        self.contactAddress = contactAddress
        self.contactPostalCode = contactPostalCode
        self.contactWebURL = contactWebURL
    }
}
