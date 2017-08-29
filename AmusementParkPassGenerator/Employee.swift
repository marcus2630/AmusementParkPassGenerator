//
//  Employee.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 14/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation

class Entrant {
    var type: EntrantType
    var profile: Profile?
    
    init(as type: EntrantType, withInformation profile: Profile?) throws {
        
        if  type == .foodService ||
            type == .maintenance ||
            type == .manager ||
            type == .rideService {
            
        // Guard that all profile requirements are filled
        guard profile?.firstName != nil && profile?.firstName != "" else {
            throw ProfileError.InvalidData(data: "first name")
        }
        
        guard profile?.lastName != nil && profile?.lastName != "" else {
            throw ProfileError.InvalidData(data: "last name")
        }
        
        guard profile?.city != nil && profile?.city != "" else {
            throw ProfileError.InvalidData(data: "city")
        }
        
        guard profile?.state != nil && profile?.state != "" else {
            throw ProfileError.InvalidData(data: "state")
        }
        
        guard profile?.street != nil && profile?.street != "" else {
            throw ProfileError.InvalidData(data: "street address")
        }
        
        guard profile?.zip != nil else {
            throw ProfileError.InvalidData(data: "zip code")
        }
            
            
        }
        
        if type == .freeChild {
            guard profile?.birthday != nil && profile?.birthday != "" else {
                throw ProfileError.InvalidData(data: "birthday")
            }
        }
        
        if type == .senior {
            guard profile?.firstName != nil && profile?.firstName != "" else { throw ProfileError.InvalidData(data: "firstname") }
            guard profile?.lastName != nil && profile?.lastName != "" else { throw ProfileError.InvalidData(data: "lastname") }
            guard profile?.birthday != nil  && profile?.birthday != "" else { throw ProfileError.InvalidData(data: "birthday") }
        }
        
        self.type = type
        self.profile = profile
    }
    
    func checkAccess(for access: Access) -> Bool {
        
        // If access is of type AreaAccess and areaAccess contains access
        if let access = access as? AreaAccess {
            if areaAccess.contains(access) {
                return true
            } else {
                return false
            }
        }
        
        // If access is of type DiscountAccess and discountAccess contains access
        if let access = access as? DiscountAccess {
            if let discountAccess = discountAccess {
                if discountAccess.contains(access) {
                    return true
                } else {
                    return false
                }
            }
        }
        
        // If access is of type RideAccess and rideAccess contains access
        if let access = access as? RideAccess {
            if rideAccess.contains(access) {
                return true
            } else {
                return false
            }
        }
        return false
    }
}

extension Entrant {
    
    // Compute accesses according to chosen employee type
    var areaAccess: [AreaAccess] {
        var areas: [AreaAccess]
        
        // Employee
        switch type {
        case .foodService, .vendor: areas = [.amusement, .kitchen]
        case .rideService:          areas = [.amusement, .rideControl]
        case .maintenance:          areas = [.amusement, .kitchen, .maintenance, .rideControl]
        case .manager:              areas = [.amusement, .kitchen, .maintenance, .office, .rideControl]
        
        // Guest
        case .classic,
             .vip,
             .senior,
             .freeChild:              areas = [.amusement]
        }
        return areas
    }
    
    var discountAccess: [DiscountAccess]? {
        var discounts: [DiscountAccess]?
        switch type {
        
        // Employee
        case .foodService,
             .maintenance,
             .rideService:          discounts = [.discountOnFood15, .discountOnMerchandise25]
        case .manager:              discounts = [.discountOnFood25, .discountOnMerchandise25]
        
        // Guest
        case .classic,
             .freeChild,
             .vendor:               discounts = nil
        case .vip:                     discounts = [.discountOnFood10, .discountOnMerchandise20]
        case .senior:                  discounts = [.discountOnFood10, .discountOnMerchandise10]
        }
        return discounts
    }
    
    var rideAccess: [RideAccess] {
        var rides: [RideAccess]
        
        switch type {
            
        // Employee
        case .foodService,
             .maintenance,
             .rideService,
             .manager:          rides = [.accessAllRides]
        
        // Guest
        case    .classic,
                .freeChild:         rides = [.accessAllRides]
        case    .vip, .senior:      rides = [.accessAllRides, .skipAllLines]
        case .vendor:               rides = [.seeEntrantAccessRules]
        }
        return rides
    }
    
    
}
