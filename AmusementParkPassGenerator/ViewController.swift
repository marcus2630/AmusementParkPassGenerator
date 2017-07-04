//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 08/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import UIKit


protocol Navigation {}
enum MainNavigation: Navigation {
    case guest, employee, manager, vendor
}

enum GuestNavigation: Navigation {
    case child, adult, senior, vip
}

enum EmployeeNavigation: Navigation {
    case foodService, rideService, maintenance
}


var mainNavigation: MainNavigation = .guest
var guestNavigation: GuestNavigation = .child
var employeeNavigation: EmployeeNavigation = .foodService

class ViewController: UIViewController {
    
    @IBOutlet weak var guestSubMenu: UIStackView!
    @IBOutlet weak var employeeSubMenu: UIStackView!
    
    // Main navigation buttons
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var employeeButton: UIButton!
    @IBOutlet weak var managerButton: UIButton!
    @IBOutlet weak var vendorButton: UIButton!
    
    // Guest navigation buttons
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var adultButton: UIButton!
    @IBOutlet weak var seniorButton: UIButton!
    @IBOutlet weak var vipButton: UIButton!
    
    // Employee navigation
    @IBOutlet weak var foodServiceButton: UIButton!
    @IBOutlet weak var rideServiceButton: UIButton!
    @IBOutlet weak var maintenanceButton: UIButton!
    
    
    @IBAction func tapNavigationButton(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        
        switch button.tag {
        
        // Main menu
        case 1: mainNavigation = .guest
        case 2: mainNavigation = .employee
        case 3: mainNavigation = .manager
        case 4: mainNavigation = .vendor
            
        // Guest menu
        case 5: guestNavigation = .child
        case 6: guestNavigation = .adult
        case 7: guestNavigation = .senior
        case 8: guestNavigation = .vip
            
        // Employee menu
        case 9: employeeNavigation = .foodService
        case 10: employeeNavigation = .rideService
        case 11: employeeNavigation = .maintenance
            
        // default
        default: mainNavigation = .guest
        }
        
        layoutSubNavigation()
        updateButtonStyles()
        highlightRequiredInputFields()
    }
    
    
    func layoutSubNavigation() {
        
        switch mainNavigation {
            
        case .guest :
            guestSubMenu.isHidden = false
            employeeSubMenu.isHidden = true
            
        case .employee :
            guestSubMenu.isHidden = true
            employeeSubMenu.isHidden = false
            
        case .manager :
            guestSubMenu.isHidden = true
            employeeSubMenu.isHidden = true
            
        case .vendor :
            guestSubMenu.isHidden = true
            employeeSubMenu.isHidden = true
        }
        
        
    }
    
    func highlightRequiredInputFields() {
        
    }
    
    func highlight(button: UIButton, size: CGFloat) {
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Kailasa-Bold", size: size)
    }
    
    func updateButtonStyles() {
        
        // Make all buttons faded
        for button in navigationButtons {
            button.setTitleColor(UIColor(red: 220/255.0, green: 212/255.0, blue: 230/255.0, alpha: 1.0), for: .normal)
            button.titleLabel?.font = UIFont(name: "Kailasa-Regular", size: 21.0)
        }
        
        // Check for buttons which should be highlighted
        switch mainNavigation {
        case .guest :       highlight(button: guestButton, size: 21.0)
        
            switch guestNavigation {
            case .child:    highlight(button: childButton, size: 16.0)
            case .adult:    highlight(button: adultButton, size: 16.0)
            case .senior:   highlight(button: seniorButton, size: 16.0)
            case .vip:      highlight(button: vipButton, size: 16.0)
            }
            
        case .employee :    highlight(button: employeeButton, size: 19.0)
            
            switch employeeNavigation {
            case .foodService:    highlight(button: foodServiceButton, size: 16.0)
            case .rideService:    highlight(button: rideServiceButton, size: 16.0)
            case .maintenance:   highlight(button: maintenanceButton, size: 16.0)
            }
        case .manager :     highlight(button: managerButton, size: 19.0)
        case .vendor :      highlight(button: vendorButton, size: 19.0)
        }
    }


    var navigationButtons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationButtons = [ // Main nav
                             guestButton,
                             employeeButton,
                             managerButton,
                             vendorButton,
                             
                             // Guest nav
                             childButton,
                             adultButton,
                             seniorButton,
                             vipButton,
            
                             // Employee nav
                             foodServiceButton,
                             rideServiceButton,
                             maintenanceButton
        ]
        
        layoutSubNavigation()
        updateButtonStyles()
        
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

