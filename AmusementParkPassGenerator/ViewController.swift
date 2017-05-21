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
        
        var freeChild: Guest
        var VIP: Guest
        var classic: Guest
        
        do {
            freeChild   =  try Guest(as: .freeChild, withInformation: Profile(freeChildWithBirthday: nil))
            VIP         =  try Guest(as: .vip, withInformation: nil)
            classic     =  try Guest(as: .classic, withInformation: nil)
        } catch GuestError.InvalidData(let data, let type) {
            print("Error, profile of type \(type) was missing \(data)")
        } catch {
            // no other erros
        }
    
        
        let defaultProfile = Profile(employeeWithFirstName: "Name", lastName: "Lastname", street: "Street", city: "City", state: "state", zip: 1111)
        
        do {
            let foodService =  try Employee(as: .foodService, withInformation: .init(employeeWithFirstName: "", lastName: nil, street: "SomeWhere", city: "Else", state: "In a state", zip: 2543))
            let rideService =  try Employee(as: .rideService, withInformation: defaultProfile)
            let maintenance =  try Employee(as: .maintenance, withInformation: defaultProfile)
            let manager     = try Employee(as: .manager, withInformation: defaultProfile)
        } catch EmployeeError.InvalidData(let data, let type) {
            print("Error, profile of type \(type) was missing \(data)")
        } catch {
            // no other erros
        }
        
        freeChild.checkAccess(for: RideAccess.skipAllLines, in: .rideAccess)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

