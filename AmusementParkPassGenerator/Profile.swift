//
//  EntrantType.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 09/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation

enum ProfileError: Error {
    case InvalidData(data: String)
    case ExpectedNumeric(data: String)
}


struct Profile {
    var firstName: String?
    var lastName: String?
    var street: String?
    var city: String?
    var state: String?
    var zip: Int?
    var birthday: String?
    var dateOfVisit: String?
    var company: String?
    
    init(firstName: String?, lastName: String?, street: String?, city: String?, state: String?, zip: Int?, birthday: String?, visit: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.street = street
        self.city = city
        self.state = state
        self.zip = zip
        self.birthday = birthday
        self.dateOfVisit = visit
    }
    
    init(employeeWithFirstName firstName: String?, lastName: String?, street: String?, city: String?, state: String?, zip: Int?) {
        self.init(firstName: firstName, lastName: lastName, street: street, city: city, state: state, zip: zip, birthday: nil, visit: nil)
    }
    
    init(freeChildWithBirthday birthday: String?) {
        self.birthday = birthday
    }
    
    init(vendorWithCompany: String?, birthday: String?, visit: String?, firstName: String?, lastName: String?) {
        self.init(firstName: firstName, lastName: lastName, street: nil, city: nil, state: nil, zip: nil, birthday: birthday, visit: visit)
        self.company = vendorWithCompany
    }
    
}

