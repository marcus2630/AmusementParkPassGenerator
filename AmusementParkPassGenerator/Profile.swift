//
//  EntrantType.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 09/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation


enum ProfileError: Error {
    case InvalidData(description: String)
}

struct Profile {
    var firstName: String?
    var lastName: String?
    var street: String?
    var city: String?
    var state: String?
    var zip: Int?
    var birthday: Date?
    
    init(withFirstName: String?, lastName: String?, street: String?, city: String?, state: String?, zip: Int?, birthday: Date?) {
        self.firstName = withFirstName
        self.lastName = lastName
        self.street = street
        self.city = city
        self.state = state
        self.zip = zip
        self.birthday = birthday
    }
    
    init(freeChildWithBirthday: Date, firstName: String?, lastName: String?, street: String?, city: String?, state: String?, zip: Int?) throws {
        self.init(withFirstName: firstName, lastName: lastName, street: street, city: city, state: state, zip: zip, birthday: freeChildWithBirthday)
        
    }
    
    init(employeeWithFirstName: String, lastName: String, street: String, city: String, state: String, zip: Int) throws {
        self.init(withFirstName: employeeWithFirstName, lastName: lastName, street: street, city: city, state: state, zip: zip, birthday: nil)
        
            
    }
}

