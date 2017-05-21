//
//  Employee.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 14/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation

enum EmployeeError: Error {
    case InvalidData(data: String, type: EmployeeType)
}

enum EmployeeType {
    case foodService
    case rideService
    case maintenance
    case manager
}

class Employee: EmployeeEntrant {
    var type: EmployeeType
    var profile: Profile
    
    init(as type: EmployeeType, withInformation profile: Profile) throws {
                
        guard profile.firstName != nil && profile.firstName != "" else {
            throw EmployeeError.InvalidData(data: "first name", type: type)
        }
        
        guard profile.lastName != nil && profile.lastName != "" else {
            throw EmployeeError.InvalidData(data: "last name", type: type)
        }
        
        guard profile.city != nil && profile.city != "" else {
            throw EmployeeError.InvalidData(data: "city", type: type)
        }
        
        guard profile.state != nil && profile.state != "" else {
            throw EmployeeError.InvalidData(data: "state", type: type)
        }
        
        guard profile.street != nil && profile.street != "" else {
            throw EmployeeError.InvalidData(data: "street address", type: type)
        }
        
        guard profile.zip != nil else {
            throw EmployeeError.InvalidData(data: "zip code", type: type)
        }
        
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
             .rideService:          discountAccess = [.discountOnFood15, .discountOnMerchandise25]
        case .manager:              discountAccess = [.discountOnFood25, .discountOnMerchandise25]
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
