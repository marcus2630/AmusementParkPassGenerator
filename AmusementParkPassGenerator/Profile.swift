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
}


struct Profile {
    var firstName: String?
    var lastName: String?
    var street: String?
    var city: String?
    var state: String?
    var zip: Int?
    var birthday: String?
    
    init(firstName: String?, lastName: String?, street: String?, city: String?, state: String?, zip: Int?, birthday: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.street = street
        self.city = city
        self.state = state
        self.zip = zip
        self.birthday = birthday
    }
    
    init(employeeWithFirstName firstName: String?, lastName: String?, street: String?, city: String?, state: String?, zip: Int?) {
        self.init(firstName: firstName, lastName: lastName, street: street, city: city, state: state, zip: zip, birthday: nil)
    }
    
    init(freeChildWithBirthday birthday: String?) {
        self.birthday = birthday
    }
}

