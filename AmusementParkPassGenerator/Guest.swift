//
//  Guest.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 14/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation



class Guest: Entrant {
    
    var type: EntrantType
    var profile: Profile?
    
    init(as type: EntrantType, withInformation profile: Profile) throws {
        
        // If free child, guard that birthday is not nil
        if type == .freeChild {
            guard profile.birthday != nil else {
                throw ProfileError.InvalidData(data: "birthday", type: type)
            }
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
            if let discountAccess = discountAccess {
                if discountAccess.contains(access) {
                    print("Access granted for \(access)!")
                } else {
                    print("Access denied \(access)!")
                }
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

extension Guest {
    
    // Compute accesses according to type chosen for guest
    var areaAccess: [AreaAccess] {
        var areas: [AreaAccess]
        
        switch type {
        case .classic,
             .vip,
             .freeChild:              areas = [.amusement]
        case .foodService:          areas = [.amusement, .kitchen]
        case .rideService:          areas = [.amusement, .rideControl]
        case .maintenance:          areas = [.amusement, .kitchen, .maintenance, .rideControl]
        case .manager:              areas = [.amusement, .kitchen, .maintenance, .office, .rideControl]
        }
        return areas
    }
    
    var discountAccess: [DiscountAccess]? {
        var discounts: [DiscountAccess]?
        switch type {
        case .classic,
             .freeChild:               discounts = nil
        case .vip:                     discounts = [.discountOnFood10, .discountOnMerchandise20]
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
        case    .classic,
                .freeChild:         rides = [.accessAllRides]
        case    .vip:               rides = [.accessAllRides, .skipAllLines]
        case .foodService,
             .maintenance,
             .rideService,
             .manager:          rides = [.accessAllRides]
        }
        return rides
    }
    
    
}
