//
//  Entrant.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 08/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation


enum GuestType {
    case classic
    case vip
    case freeChild
}

enum EmployeeType {
    case foodService
    case rideService
    case maintenance
    case manager
}


// MARK: - PROTOCOLS


protocol Entrant {
    var areaAccess: [AreaAccess] { get }
    var rideAccess: [RideAccess] { get }
}

protocol GuestEntrant: Entrant {
    var type: GuestType { get }
    var discountAcces: [DiscountAccess]? { get }
    var profile: Profile? { get set }
}

protocol EmployeeEntrant: Entrant {
    var type: EmployeeType { get }
    var discountAccess: [DiscountAccess] { get }
    var profile: Profile { get set }
}




// MARK: - CLASSES

class Guest: GuestEntrant {
    
    var type: GuestType
    var profile: Profile?
    
    init(as type: GuestType, withInformation profile: Profile) {
        self.type = type
        self.profile = profile
    }
}

class Employee: EmployeeEntrant {
    var type: EmployeeType
    var profile: Profile
    
    init(as type: EmployeeType, withInformation profile: Profile) {
        self.type = type
        self.profile = profile
    }
}

enum EntrantError: Error {
    case firstNameMissing
}


// MARK: - EXTENSIONS

extension Employee {
    var areaAccess: [AreaAccess] {
        var areaAccess: [AreaAccess]
        
        switch type {
        case .foodService:          areaAccess = [.amusement, .kitchen]
        case .rideService:          areaAccess = [.amusement, .rideControl]
        case .maintenance:          areaAccess = [.amusement, .kitchen, .maintenance, .rideControl]
        case .manager:              areaAccess = [.amusement, .kitchen, .maintenance, .office, .rideControl]
        }
        return areaAccess
    }
    
    var discountAccess: [DiscountAccess] {
        var discountAccess: [DiscountAccess]
        switch type {
        case .foodService,
             .maintenance,
             .rideService:          discountAccess = [.discountOnFood(.fifteen), .discountOnMerchandise(.twentyFive)]
        case .manager:              discountAccess = [.discountOnFood(.twentyFive), .discountOnMerchandise(.twentyFive)]
        }
        return discountAccess
    }
    
    var rideAccess: [RideAccess] {
        var rides: [RideAccess]
        
        switch type {
             case .foodService,
                  .maintenance,
                  .rideService,
                  .manager:          rides = [.accessAllRides]
        }
        return rides
    }
    
    
}

extension Guest {
   var areaAccess: [AreaAccess] {
        var areaAccess: [AreaAccess]

        switch type {
        case .classic,
             .vip,
             .freeChild:              areaAccess = [.amusement]
        }
        return areaAccess
    }
    
    var discountAcces: [DiscountAccess]? {
        var discountAccess: [DiscountAccess]?
        switch type {
        case .classic,
             .freeChild:               discountAccess = nil
        case .vip:                     discountAccess = [.discountOnFood(.ten), .discountOnMerchandise(.twentyFive)]
        }
        return discountAccess
    }
    
    var rideAccess: [RideAccess] {
        var rides: [RideAccess]
        
        switch type {
            case    .classic,
                    .freeChild:         rides = [.accessAllRides]
            case    .vip:               rides = [.accessAllRides, .skipAllLines]
        }
        return rides
    }
    
    
}





