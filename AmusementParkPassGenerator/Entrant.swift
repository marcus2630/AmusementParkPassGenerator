//
//  Entrant.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 08/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation


enum GuestType {
    case classicGuest
    case vipGuest
    case freeChildGuest
}

enum EmployeeType {
    case hourlyEmployeeFoodService
    case hourlyEmployeeRideService
    case hourlyEmployeeMaintenance
    case manager
}


// MARK: - PROTOCOLS



protocol GuestEntrant {
    var type: GuestType { get }
    var discountAcces: [DiscountAccess]? { get }
    var profile: Profile? { get set }
}

protocol EmployeeEntrant {
    var type: EmployeeType { get }
    var discountAccess: [DiscountAccess] { get }
    var profile: Profile { get set }
}




// MARK: - CLASSES

class Guest: GuestEntrant {
    
    var type: GuestType
    var profile: Profile?
    
    init(_ type: GuestType, profile: Profile) {
        self.type = type
        self.profile = profile
    }
}

class Employee: EmployeeEntrant {
    var type: EmployeeType
    var profile: Profile
    
    init(_ type: EmployeeType, profile: Profile) {
        self.type = type
        self.profile = profile
    }
}



// MARK: - EXTENSIONS

extension Employee {
    var areaAccess: [AreaAccess] {
        var areaAccess: [AreaAccess]
        
        switch type {
        case .hourlyEmployeeFoodService:    areaAccess = [.amusement, .kitchen]
        case .hourlyEmployeeRideService:    areaAccess = [.amusement, .rideControl]
        case .hourlyEmployeeMaintenance:    areaAccess = [.amusement, .kitchen, .maintenance, .rideControl]
        case .manager:                      areaAccess = [.amusement, .kitchen, .maintenance, .office, .rideControl]
        }
        return areaAccess
    }
    
    var discountAccess: [DiscountAccess] {
        var discountAccess: [DiscountAccess]
        switch type {
        case .hourlyEmployeeFoodService,
             .hourlyEmployeeMaintenance,
             .hourlyEmployeeRideService:    discountAccess = [.discountOnFood(.fifteen), .discountOnMerchandise(.twentyFive)]
        case .manager:                      discountAccess = [.discountOnFood(.twentyFive), .discountOnMerchandise(.twentyFive)]
        }
        return discountAccess
    }
    
    var rideAccess: [RideAccess] {
        var rides: [RideAccess]
        
        switch type {
             case .hourlyEmployeeFoodService,
                  .hourlyEmployeeMaintenance,
                  .hourlyEmployeeRideService,
                  .manager:                      rides = [.accessAllRides]
        }
        return rides
    }
    
    
}

extension Guest {
   var areaAccess: [AreaAccess] {
        var areaAccess: [AreaAccess]

        switch type {
        case .classicGuest,
             .vipGuest,
             .freeChildGuest:               areaAccess = [.amusement]
        }
        return areaAccess
    }
    
    var discountAcces: [DiscountAccess]? {
        var discountAccess: [DiscountAccess]?
        switch type {
        case .classicGuest,
             .freeChildGuest:               discountAccess = nil
        case .vipGuest:                     discountAccess = [.discountOnFood(.ten), .discountOnMerchandise(.twentyFive)]
        }
        return discountAccess
    }
    
    var rideAccess: [RideAccess] {
        var rides: [RideAccess]
        
        switch type {
            case    .classicGuest,
                    .freeChildGuest:               rides = [.accessAllRides]
            case    .vipGuest:                     rides = [.accessAllRides, .skipAllLines]
        }
        return rides
    }
    
    
}





