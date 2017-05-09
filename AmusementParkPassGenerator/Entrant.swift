//
//  Entrant.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 08/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import Foundation


extension Entrant {
   var areaAccess: [AreaAccess] {
        var areaAccess: [AreaAccess]

        switch type {
        case .classicGuest,
             .vipGuest,
             .freeChildGuest:               areaAccess = [.amusement]
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
        case .classicGuest,
             .freeChildGuest:               discountAccess = []
        case .vipGuest:                     discountAccess = [.discountOnFood(.ten), .discountOnMerchandise(.twentyFive)]
        
        case .hourlyEmployeeFoodService,
             .hourlyEmployeeMaintenance,
             .hourlyEmployeeRideService:    discountAccess = [.discountOnFood(.fifteen), .discountOnMerchandise(.twentyFive)]
        case .manager:                      discountAccess = [.discountOnFood(.twentyFive), .discountOnMerchandise(.twentyFive)]
        }
        return discountAccess
    }
    
    
}




struct Entrant {
    var type: EntrantType = .classicGuest
    
    init(_ type: EntrantType) {
        self.type = type
    }
}

