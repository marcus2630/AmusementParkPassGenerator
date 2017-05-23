//
//  Guest.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 14/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation

enum GuestError: Error {
    case InvalidData(data: String, type: GuestType)
}

enum GuestType {
    case classic
    case vip
    case freeChild
}

class Guest: GuestEntrant {
    
    var type: GuestType
    var profile: Profile?
    
    init(as type: GuestType, withInformation profile: Profile?) throws {
        
        if type == .freeChild {
            guard profile?.birthday != nil else {
                throw GuestError.InvalidData(data: "birthday", type: type)
            }
        }
        
        self.type = type
        self.profile = profile
    }
    
    func checkAccess(for access: Access) {
        
        if let access = access as? AreaAccess {
            if areaAccess.contains(access) {
                    print("Access granted \(access)!")
                } else {
                    print("Access denied \(access)!")
                }
        }
        
        
        if let access = access as? DiscountAccess {
            
            if let discountAccess = discountAccess {
                if discountAccess.contains(access) {
                    print("Access granted for \(access)!")
                } else {
                    print("Access denied \(access)!")
                }
            }
        }
        
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
    var areaAccess: [AreaAccess] {
        var areaAccess: [AreaAccess]
        
        switch type {
        case .classic,
             .vip,
             .freeChild:              areaAccess = [.amusement]
        }
        return areaAccess
    }
    
    var discountAccess: [DiscountAccess]? {
        var discountAccess: [DiscountAccess]?
        switch type {
        case .classic,
             .freeChild:               discountAccess = nil
        case .vip:                     discountAccess = [.discountOnFood10, .discountOnMerchandise20]
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
