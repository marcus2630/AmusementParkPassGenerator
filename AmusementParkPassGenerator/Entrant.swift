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
}

protocol EmployeeEntrant: Entrant {
    var type: EmployeeType { get }
    var discountAccess: [DiscountAccess] { get }
    var profile: Profile { get set }
}

protocol GuestEntrant: Entrant {
    var type: GuestType { get }
    var discountAcces: [DiscountAccess]? { get }
    var profile: Profile? { get set }
}




