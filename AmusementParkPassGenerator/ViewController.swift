//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 08/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            
            //-- Create classic guest
            // let classicGuest = try Guest(as: .classic, withInformation: nil)
            // classicGuest.checkAccess(for: AreaAccess.kitchen)
            // classicGuest.checkAccess(for: RideAccess.accessAllRides)
            
            
            // Create free child, will fail gracefully as birthday is mising
            // let freeChild = try Guest(as: .freeChild, withInformation: Profile(freeChildWithBirthday: nil))
            
            
            //-- Create VIP Guest
            // VIP = try Guest(as: .vip, withInformation: nil)
            // VIP.checkAccess(for: DiscountAccess.discountOnMerchandise20)
            // VIP.checkAccess(for: RideAccess.skipAllLines)
            
            
            //---- DEFAULT EMPLOYEE PROFILE
            var profile = Profile(employeeWithFirstName: "Marcus", lastName: "Klausen", street: "Somewhere", city: "Unknown", state: "Denmark doesn't have states", zip: 2630)
            
            //-- Create foodService employee
            // let foodService = try Employee(as: .foodService, withInformation: profile)
            // foodService.checkAccess(for: AreaAccess.maintenance)
            // foodService.checkAccess(for: DiscountAccess.discountOnMerchandise25)
            
            //-- Create maintenance employee
            // let maintenance = try Employee(as: .maintenance, withInformation: profile)
            // maintenance.checkAccess(for: RideAccess.skipAllLines)
            // maintenance.checkAccess(for: AreaAccess.kitchen)
            
            
            profile.firstName = ""
            
            // Other tests
            // profile.state = nil
            // profile.street = ""
            // profile.city = nil
            
            //-- Create ride service employee - fails since firstName of profile is empty
            // let rideService = try Employee(as: .maintenance, withInformation: profile)
            
            // Use only if you place string in profile.firstName
            // rideService.checkAccess(for: AreaAccess.office)
            // rideService.checkAccess(for: RideAccess.accessAllRides)
            
            profile.firstName = "manager"
            
            let manager = try Employee(as: .manager, withInformation: profile)
            manager.checkAccess(for: AreaAccess.office)
            manager.checkAccess(for: DiscountAccess.discountOnFood25)
            
            
        } catch ProfileError.InvalidData(let data, let type) {
            print("Error, \(type) was missing \(data)")
        } catch {
            print("Other error occured")
        }
    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

