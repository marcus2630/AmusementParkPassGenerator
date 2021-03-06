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
        
        
        switch type {
        case .foodService, .maintenance, .manager, .rideService:
            
            // Guard that all profile requirements are filled
            guard profile?.firstName != nil && profile?.firstName != ""     else { throw ProfileError.InvalidData(data: "first name")}
            guard profile?.lastName != nil && profile?.lastName != ""       else { throw ProfileError.InvalidData(data: "last name")}
            guard profile?.city != nil && profile?.city != ""               else { throw ProfileError.InvalidData(data: "city")}
            guard profile?.state != nil && profile?.state != ""             else { throw ProfileError.InvalidData(data: "state")}
            guard profile?.street != nil && profile?.street != ""           else { throw ProfileError.InvalidData(data: "street address")}
            guard profile?.zip != nil                                       else { throw ProfileError.InvalidData(data: "zip code")}
            
            
        case .freeChild:
            
            if let birthday = profile?.birthday {
                if birthday != "" {
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy/MM/dd"
                    
                    let formattedDate = formatter.date(from: birthday)
                    
                    if let formattedDate = formattedDate {
                    
                        print(formattedDate.countDaysTo(date: Date(timeIntervalSinceNow: 0))-1)
                        if (formattedDate.countDaysTo(date: Date(timeIntervalSinceNow: 0)))-1 > 5*365 {
                            print("Duuh!")
                            throw ProfileError.InvalidAge(data: String(describing: birthday))
                        }
                    }
                    
                } else { throw ProfileError.InvalidData(data: "birthday")}
                
            } else { throw ProfileError.InvalidData(data: "birthday")}
            
            

            
            
        case .senior:
            
            guard profile?.firstName != nil && profile?.firstName != ""     else { throw ProfileError.InvalidData(data: "firstname")}
            guard profile?.lastName != nil && profile?.lastName != ""       else { throw ProfileError.InvalidData(data: "lastname")}
            guard profile?.birthday != nil  && profile?.birthday != ""      else { throw ProfileError.InvalidData(data: "birthday")}
            
            
        case .vendor:
            
            guard profile?.dateOfVisit != nil  && profile?.dateOfVisit != ""    else { throw ProfileError.InvalidData(data: "date of visit")}
            guard profile?.birthday != nil  && profile?.birthday != ""          else { throw ProfileError.InvalidData(data: "birthday")}
            guard profile?.firstName != nil && profile?.firstName != ""         else { throw ProfileError.InvalidData(data: "firstname")}
            guard profile?.lastName != nil && profile?.lastName != ""           else { throw ProfileError.InvalidData(data: "lastname")}
            guard profile?.company != nil && profile?.company != ""             else { throw ProfileError.InvalidData(data: "company name")}
            
            
        default: break
        }
        
        
        self.type = type
        self.profile = profile
    }
    
    func checkAccess(for access: Access?) -> (access: Bool, message: String) {
        
        // If access is of type AreaAccess and areaAccess contains access
        if let access = access as? AreaAccess {
            if areaAccess.contains(access) {
                switch access {
                case .amusement: return (true, "Access granted for amusement area.")
                case .kitchen: return (true, "Access granted for kitchen area.")
                case .maintenance: return (true, "Access granted for maintenence area.")
                case .office: return (true, "Access granted for office areas.")
                case .rideControl: return (true, "Access granted for ride control areas.")
                }
            } else {
                switch access {
                case .amusement: return (false, "Access denied for amusement area.")
                case .kitchen: return (false, "Access denied for kitchen area.")
                case .maintenance: return (false, "Access denied for maintenence area.")
                case .office: return (false, "Access denied for office areas.")
                case .rideControl: return (false, "Access denied for ride control areas.")
                }
            }
        }
        
        if access is Discounts? {
            
            if let discounts = discountAccess {
                
                
                // If access is of type DiscountAccess and discountAccess contains access
                if  let foodDiscount = discounts.foodDiscount {
                    
                    // If there's also a merchant discount
                    if let merchantDiscount = discounts.merchantDiscount {
                        return (true, "This pass has a \(merchantDiscount)% discount on merchandise.\nThis pass also has a \(foodDiscount)% discount on food.")
                    }
                    
                    // Else if only food discount
                    return (true, "This pass has a \(foodDiscount)% discount on food.")
                    
                } else {
                    
                    // Else if only merchant discount
                    if let merchantDiscount = discounts.merchantDiscount {
                        return (true, "This pass has a \(merchantDiscount)% discount on merchandise.")
                    }
                }
                
            } else {
                
                // If no discounts at all
                return (false, "This pass has no discounts")
            }
        }
        
        
        // If access is of type RideAccess and rideAccess contains access
        if let access = access as? RideAccess {
            if rideAccess.contains(access) {
                switch access {
                case .accessAllRides: return (true, "Pass grants access to all rides.")
                case .skipAllLines: return (true, "Guest may skip the lines.")
                case .seeEntrantAccessRules: return (true, "May see guests access rules.")
                }
            } else {
                switch access {
                case .accessAllRides: return (false, "Pass does NOT grant access to rides.")
                case .skipAllLines: return (false, "Guest may NOT skip the lines.")
                case .seeEntrantAccessRules: return (false, "Is not allowed to see guests access rules.")
                }
            }
        }
        print("discount was run")
        return (false, "Couldn't check the specified access criteria.")
        
    }
}

extension Entrant {
    
    // Compute accesses according to chosen employee type
    var areaAccess: [AreaAccess] {
        
        var areas: [AreaAccess]
        
        switch type {
        
        // Employee
        case .foodService, .vendor, .contractor:        areas = [.amusement, .kitchen]
        case .rideService:                              areas = [.amusement, .rideControl]
        case .maintenance:                              areas = [.amusement, .kitchen, .maintenance, .rideControl]
        case .manager:                                  areas = [.amusement, .kitchen, .maintenance, .office, .rideControl]
            
        // Guest
        case .classic, .vip, .senior, .freeChild:       areas = [.amusement]
        }
        return areas
    }
    
    var discountAccess: Discounts? {
        
        var discounts: Discounts?
        switch type {
            
        // Employee
        case .foodService, .maintenance, .rideService:      discounts = Discounts(foodDiscount: 15, merchantDiscount: 15)
        case .manager:                                      discounts = Discounts(foodDiscount: 25, merchantDiscount: 25)
            
        // Guest
        case .classic, .freeChild, .vendor, .contractor:    discounts = nil
        case .vip:                                          discounts = Discounts(foodDiscount: 10, merchantDiscount: 20)
        case .senior:                                       discounts = Discounts(foodDiscount: 10, merchantDiscount: 10)
        }
        return discounts
    }
    
    var rideAccess: [RideAccess] {
        var rides: [RideAccess]
        
        switch type {
            
        // Employee
        case .foodService, .maintenance, .rideService, .manager:    rides = [.accessAllRides]
            
        // Guest
        case    .classic, .freeChild:                               rides = [.accessAllRides]
        case    .vip, .senior:                                      rides = [.accessAllRides, .skipAllLines]
        case .vendor, .contractor:                                  rides = [.seeEntrantAccessRules]
        }
        
        return rides
    }
    
    
}
