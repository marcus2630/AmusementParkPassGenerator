//
//  Area.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 09/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation

typealias percent = Int


// Access overall type
protocol Access {}

enum AreaAccess: Access {
    case amusement
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum RideAccess: Access {
    case accessAllRides
    case skipAllLines
    case seeEntrantAccessRules
}


struct Discounts: Access {
    let foodDiscount: Int?
    let merchantDiscount: Int?

}

