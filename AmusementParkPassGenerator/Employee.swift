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
        
        // Guard that all profile requirements are filled
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
    
    func checkAccess(for access: Access) {
        
        // If access is of type AreaAccess and areaAccess contains access
        if let access = access as? AreaAccess {
            if areaAccess.contains(access) {
                print("Access granted \(access)!")
            } else {
                print("Access denied \(access)!")
            }
        }
        
        // If access is of type DiscountAccess and discountAccess contains access
        if let access = access as? DiscountAccess {
                if discountAccess.contains(access) {
                    print("Access granted for \(access)!")
                } else {
                    print("Access denied \(access)!")
                }
        }
        
        // If access is of type RideAccess and rideAccess contains access
        if let access = access as? RideAccess {
            if rideAccess.contains(access) {
                print("Access granted \(access)!")
            } else {
                print("Access denied \(access)!")
            }
        }
    }
}

extension Employee {
    
    // Compute accesses according to chosen employee type
    var areaAccess: [AreaAccess] {
        var areas: [AreaAccess]
        
        switch type {
        case .foodService:          areas = [.amusement, .kitchen]
        case .rideService:          areas = [.amusement, .rideControl]
        case .maintenance:          areas = [.amusement, .kitchen, .maintenance, .rideControl]
        case .manager:              areas = [.amusement, .kitchen, .maintenance, .office, .rideControl]
        }
        return areas
    }
    
    var discountAccess: [DiscountAccess] {
        var discounts: [DiscountAccess]
        switch type {
        case .foodService,
             .maintenance,
             .rideService:          discounts = [.discountOnFood15, .discountOnMerchandise25]
        case .manager:              discounts = [.discountOnFood25, .discountOnMerchandise25]
        }
        return discounts
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
