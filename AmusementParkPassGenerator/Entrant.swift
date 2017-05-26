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
    var type: EntrantType { get set }
    func checkAccess(for access: Access)
}




enum EntrantType {
    case foodService
    case rideService
    case maintenance
    case manager
    case classic
    case vip
    case freeChild
}

