//
//  Entrant.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 08/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation


protocol Entrant {
    var areaAccess: [AreaAccess] { get }
    var rideAccess: [RideAccess] { get }
    func checkAccess(for access: Access) -> Bool
}

protocol EmployeeEntrant: Entrant {
    var type: EntrantType { get }
    var discountAccess: [DiscountAccess] { get }
    var profile: Profile { get set }
}

protocol GuestEntrant: Entrant {
    var type: EntrantType { get }
    var discountAccess: [DiscountAccess]? { get }
    var profile: Profile? { get set }
}


//protocol EntrantType {}
//
//enum EmployeeType: EntrantType {
//    case foodService
//    case rideService
//    case maintenance
//    case manager
//}
//
//enum GuestType: EntrantType {
//    case classic
//    case vip
//    case freeChild
//}

enum EntrantType {
    // Employee
    case foodService, rideService, maintenance, manager
    
    // Guest
    case classic, vip, freeChild, senior
}


