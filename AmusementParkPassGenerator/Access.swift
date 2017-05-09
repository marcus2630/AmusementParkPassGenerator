//
//  Area.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 09/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation

enum AreaAccess {
    case amusement
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum RideAccess {
    case accessAllRides
    case skipAllLines
}


enum DiscountRate: Int {
    case ten = 10
    case fifteen = 15
    case twenty = 20
    case twentyFive = 25
}

enum DiscountAccess {
    case discountOnFood(DiscountRate)
    case discountOnMerchandise(DiscountRate)
}

