//
//  Area.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 09/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation

typealias percent = Int

enum Access {
    case areaAccess, rideAccess, discountAccess
}

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





// Having associated values on enum when casting to it gives error: Cannot convert type foo to argument type '_NilOptionalComparisonType'
//    enum DiscountAccess {
//    case discountOnFood(percent)
//    case discountOnMerchandise(percent)
//      }

// Work around for now, individual cases

enum DiscountAccess {
    case discountOnFood10, discountOnFood15, discountOnFood20, discountOnFood25
    case discountOnMerchandise10, discountOnMerchandise15, discountOnMerchandise20, discountOnMerchandise25
}

