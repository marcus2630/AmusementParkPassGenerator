//
//  Guest.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 14/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation



class Guest: GuestEntrant {
    
    var type: EntrantType
    var profile: Profile?
    
    init(as type: EntrantType, withInformation profile: Profile?) throws {
        
        
        /* 
           Checking profiles for different types
        */
        if type == .freeChild {
            guard profile?.birthday != nil else {
                throw ProfileError.InvalidData(data: "birthday")
            }
        }
        
        if type == .senior {
            guard profile?.firstName != nil else { throw ProfileError.InvalidData(data: "firstname") }
            guard profile?.firstName != nil else { throw ProfileError.InvalidData(data: "lastname") }
            guard profile?.birthday != nil else { throw ProfileError.InvalidData(data: "firstname") }
        }
        
        
        self.type = type
        self.profile = profile
    }
    
    func checkAccess(for access: Access) -> Bool {
        
        // If access is of type AreaAccess and areaAccess contains access
        if let access = access as? AreaAccess {
            if areaAccess.contains(access) {
                print("Access granted \(access)!")
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

extension Guest {
    
    // Compute accesses according to type chosen for guest
    var areaAccess: [AreaAccess] {
        var areas: [AreaAccess]
        
        switch type {
        case .classic,
             .vip,
             .senior,
             .freeChild:              areas = [.amusement]
        default: areas = []
        }
        return areas
    }
    
    var discountAccess: [DiscountAccess]? {
        var discounts: [DiscountAccess]?
        switch type {
        case .classic,
             .freeChild:               discounts = nil
        case .vip:                     discounts = [.discountOnFood10, .discountOnMerchandise20]
        case .senior:                  discounts = [.discountOnFood10, .discountOnMerchandise10]
        default: discounts = []
        }
        return discounts
    }
    
    var rideAccess: [RideAccess] {
        var rides: [RideAccess]
        
        switch type {
        case    .classic,
                .freeChild:         rides = [.accessAllRides]
        case    .vip, .senior:      rides = [.accessAllRides, .skipAllLines]
        default: rides = []
        }
        return rides
    }
    
    
}
