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
    
    func checkAccess(for access: Any, in accessType: Access) {
        if accessType == .areaAccess {
            for area in areaAccess {
                if area == access as? AreaAccess {
                    print("Access granted!")
                } else {
                    print("Access denied!")
                }
            }
        }
        
        if accessType == .discountAccess {
            if let discountAccess = discountAccess {
                for discount in discountAccess {
                    if discount == access as? DiscountAccess {
                        print("Access granted!")
                    } else {
                        print("Access denied!")
                    }
                }
            }
        }
        
        if accessType == .rideAccess {
            for ride in rideAccess {
                if ride == access as? RideAccess {
                    print("Access granted!")
                } else {
                    print("Access denied")
                }
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
