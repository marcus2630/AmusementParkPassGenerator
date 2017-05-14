//
//  Employee.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 14/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation

enum EmployeeType {
    case foodService
    case rideService
    case maintenance
    case manager
}

class Employee: EmployeeEntrant {
    var type: EmployeeType
    var profile: Profile
    
    init(as type: EmployeeType, withInformation profile: Profile) {
        self.type = type
        self.profile = profile
    }
}

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
