//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 08/05/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import UIKit


/* NAVIGATION
-----------------------------*/

enum MainNavigation {
    case guest, employee, manager, vendor, contractor
}

enum SubNavigation {
        // Guest
        case child, adult, senior, vip
    
        // Employee
        case foodService, rideService, maintenance
}

class Navigation {
    var main: MainNavigation
    var sub: EntrantType
    
    init(mainNavigation: MainNavigation, subNavigation: EntrantType) {
        self.main = mainNavigation
        self.sub = subNavigation
    }
}

// Create the navigation instane
let navigation = Navigation(mainNavigation: .guest, subNavigation: .freeChild)

/* -----------------------------*/


class ViewController: UIViewController, PassViewControllerDelegate {
    
    // Outlets for the sub navigations for show/hide functionality
    @IBOutlet weak var guestSubMenu: UIStackView!
    @IBOutlet weak var employeeSubMenu: UIStackView!
    
    // Main navigation buttons
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var employeeButton: UIButton!
    @IBOutlet weak var managerButton: UIButton!
    @IBOutlet weak var vendorButton: UIButton!
    @IBOutlet weak var contractorButton: UIButton!
    
    // Guest navigation buttons
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var adultButton: UIButton!
    @IBOutlet weak var seniorButton: UIButton!
    @IBOutlet weak var vipButton: UIButton!
    
    // Employee navigation
    @IBOutlet weak var foodServiceButton: UIButton!
    @IBOutlet weak var rideServiceButton: UIButton!
    @IBOutlet weak var maintenanceButton: UIButton!
    
    // Form outlets
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var dateOfVisit: UITextField!
    @IBOutlet weak var project: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    
    
    
    /* Prepare for segue
     -----------------------------*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Prepare for GameFinishedVC transition
        if segue.identifier == "GeneratePass" {
            
            if let destination = segue.destination as? PassViewController {
                
                // Set GameFinishedViewControllers score var to this VCs score var
                if let entrant = sender {
                    
                    destination.entrant = entrant as? Entrant
                    
                } else {
                    
                    print("entrant empty")
                }
                
                // Initialize delegate on this VC otherwise it wont work
                destination.delegate = self
            }
            
        }
    }
    
    /*-----------------------------*/
    
    
    
    // Populeate data, switch on which navigation item we're on
    @IBAction func populateData(_ sender: Any) {
        
        switch navigation.sub {
            
        case .foodService, .rideService, .maintenance, .manager:
            firstName.text = "Magnus"
            lastName.text = "Rasmussen"
            dateOfBirth.text = "26-03-1995"
            streetAddress.text = "Jyllingevej 12"
            city.text = "Copenhagen"
            state.text = "Sjaelland Island"
            zipCode.text = "1620"
            
        case .freeChild:
            dateOfBirth.text = "16-05-2005"
            
        case .senior:
            dateOfBirth.text = "05-12-1956"
            firstName.text = "John"
            lastName.text = "Smith"
            
        case .vendor:
            dateOfBirth.text = "24-03-1967"
            dateOfVisit.text = "14-04-2017"
            firstName.text = "Julie"
            lastName.text = "Rosengaard"
            company.text = "Treehouse Inc."
            
        case .contractor:
            firstName.text = "Sigurd"
            lastName.text = "Larsen"
            streetAddress.text = "Somewhere along the road"
            city.text = "Taastrup"
            state.text = "Jylland Island"
            zipCode.text = "6400"
            
        default: break
        }
    }
    
    
    // Declared entrant to avoid scope issues
    var entrant: Entrant? = nil
    
    
    /* USER GENERATES PASS -------> */
    @IBAction func generatePassAndSegue(_ sender: Any) {
        
        
            do {
                
                // Try to convert zip code to int
                let zipCodeAsInt = try convertTextFieldToInt(value: zipCode)
                
                // init profile for scoping
                let profile: Profile?
                
                
                // Switch on entrant / nagivation types
                switch navigation.main {
                    
                case .employee:
                    profile = Profile(employeeWithFirstName: firstName.text, lastName: lastName.text, street: streetAddress.text, city: city.text, state: state.text, zip: zipCodeAsInt)

                case .manager:
                    profile = Profile(employeeWithFirstName: firstName.text, lastName: lastName.text, street: streetAddress.text, city: city.text, state: state.text, zip: zipCodeAsInt)
                    
                case .vendor:
                    profile = Profile(vendorWithCompany: company.text, birthday: dateOfBirth.text, visit: dateOfVisit.text, firstName: firstName.text, lastName: lastName.text)
                    
                case .contractor:
                    profile = Profile(firstName: firstName.text, lastName: lastName.text, street: streetAddress.text, city: city.text, state: state.text, zip: zipCodeAsInt, birthday: nil, visit: nil)
                    
                case .guest:
                    
                    // Switch on guest types
                    switch navigation.sub {
                    case .freeChild: profile = Profile(freeChildWithBirthday: dateOfBirth.text)
                    default: profile = Profile(firstName: firstName.text, lastName: lastName.text, street: streetAddress.text, city: city.text, state: state.text, zip: zipCodeAsInt, birthday: dateOfBirth.text, visit: nil)
                    }
                }
                
                
                // try to create the entrant with with entrant types correct profile
                entrant = try Entrant(as: navigation.sub, withInformation: profile)
                
                if entrant != nil {
                    
                    // Let's segue
                    performSegue(withIdentifier: "GeneratePass", sender: entrant)
                }
                
                
            // Catch missing data errors
            } catch ProfileError.InvalidData(let data) {
                
                // Set set message and create alert
                let message = "Please fill in the \(data), before generating a pass."
                let alert = UIAlertController(title: "Missing information", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,
                                              handler: nil))
                
                present(alert, animated: true, completion: nil)
              
            // Catch errors due to number fields not being Integer
            } catch ProfileError.ExpectedNumeric(let data) {
                
                let message = "Please please make sure that \(data) is numbers only."
                let alert = UIAlertController(title: "Wrong format", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,
                                              handler: nil))
                
                present(alert, animated: true, completion: nil)
                
            // Any other errors?
            } catch {
                print("Other error occured")
            }
        
    }
    
    /* <------- USER GENERATES PASS */
    
    
    
    @IBAction func tapNavigationButton(_ sender: Any) {
        
        // Check if sender is UIButton
        guard let button = sender as? UIButton else { return }
        
        // Switch on button tag attribute
        switch button.tag {
        
        // Main menu
        case 1: navigation.main = .guest
                navigation.sub = .freeChild
                highlight(button: childButton, size: 16.0)
            
        case 2: navigation.main = .employee
                navigation.sub = .foodService
                highlight(button: foodServiceButton, size: 16.0)
            
            
        case 3: navigation.main = .manager
                navigation.sub  = .manager
            
        case 4: navigation.main = .vendor
                navigation.sub  = .vendor
        case 12: navigation.main = .contractor
                 navigation.sub = .contractor
            
        // Guest menu
        case 5: navigation.sub = .freeChild
        case 6: navigation.sub = .classic
        case 7: navigation.sub = .senior
        case 8: navigation.sub = .vip
            
        // Employee menu
        case 9: navigation.sub = .foodService
        case 10: navigation.sub = .rideService
        case 11: navigation.sub = .maintenance
            
        // default
        default: navigation.main = .guest
            navigation.sub = .freeChild
        }
        
        // Clear fields, highlight required fields, hide or show subnavigation and update button styles for hover effect
        clearFields()
        highlightRequiredInputFields()
        layoutSubNavigation()
        updateButtonStyles()
    }
    

    // Declared for scoping
    var navigationButtons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationButtons = [
        
            // Main nav
            guestButton, employeeButton, managerButton, vendorButton, contractorButton,
                             
            // Guest nav
            childButton, adultButton, seniorButton, vipButton,
            
            // Employee nav
            foodServiceButton, rideServiceButton, maintenanceButton
        
        ]
        
        // Highlight required fields, hide or show subnavigation and update button styles for hover effect
        layoutSubNavigation()
        updateButtonStyles()
        highlightRequiredInputFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    /* HELPER FUNCTIONS {
     -----------------------------*/
    
    func convertTextFieldToInt(value: UITextField) throws -> Int? {
        var intValue: Int? = nil
        if let value = value.text {
            intValue = Int(value)
        } else {
            throw ProfileError.ExpectedNumeric(data: "zip code")
        }
        return intValue
    }
    
    
    
    func highlight(button: UIButton, size: CGFloat) {
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Kailasa-Bold", size: size)
    }
    
    
    
    func highlightRequiredInputFields() {
        
        dateOfBirth.backgroundColor = UIColor.clear
        dateOfVisit.backgroundColor = UIColor.clear
        firstName.backgroundColor = UIColor.clear
        lastName.backgroundColor = UIColor.clear
        company.backgroundColor = UIColor.clear
        project.backgroundColor = UIColor.clear
        streetAddress.backgroundColor = UIColor.clear
        city.backgroundColor = UIColor.clear
        state.backgroundColor = UIColor.clear
        zipCode.backgroundColor = UIColor.clear
        
        
        if navigation.main == .employee || navigation.main == .manager {
            dateOfBirth.backgroundColor = UIColor.white
            firstName.backgroundColor = UIColor.white
            lastName.backgroundColor = UIColor.white
            streetAddress.backgroundColor = UIColor.white
            city.backgroundColor = UIColor.white
            state.backgroundColor = UIColor.white
            zipCode.backgroundColor = UIColor.white
        }
        
        if navigation.main == .vendor {
            dateOfBirth.backgroundColor = UIColor.white
            dateOfVisit.backgroundColor = UIColor.white
            firstName.backgroundColor = UIColor.white
            lastName.backgroundColor = UIColor.white
            company.backgroundColor = UIColor.white
            
        }
        
        if navigation.main == .contractor {
            firstName.backgroundColor = UIColor.white
            lastName.backgroundColor = UIColor.white
            streetAddress.backgroundColor = UIColor.white
            city.backgroundColor = UIColor.white
            state.backgroundColor = UIColor.white
            zipCode.backgroundColor = UIColor.white
            
        }
        
        switch navigation.sub {
            
        case .freeChild:
            dateOfBirth.backgroundColor = UIColor.white
            
        case .senior:
            dateOfBirth.backgroundColor = UIColor.white
            firstName.backgroundColor = UIColor.white
            lastName.backgroundColor = UIColor.white
        default: break
        }
    }
    
    
    
    func clearFields() {
        dateOfBirth.text = nil
        dateOfVisit.text = nil
        project.text = nil
        firstName.text = nil
        lastName.text = nil
        company.text = nil
        streetAddress.text = nil
        city.text = nil
        state.text = nil
        zipCode.text = nil
    }
    
    
    
    func layoutSubNavigation() {
        
        switch navigation.main {
            
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
        case .contractor :
            guestSubMenu.isHidden = true
            employeeSubMenu.isHidden = true
        }
    }
    
    
    
    func updateButtonStyles() {
        
        // Make all buttons faded
        for button in navigationButtons {
            button.setTitleColor(UIColor(red: 220/255.0, green: 212/255.0, blue: 230/255.0, alpha: 1.0), for: .normal)
            button.titleLabel?.font = UIFont(name: "Kailasa-Regular", size: 21.0)
        }
        
        // Check for buttons which should be highlighted
        switch navigation.main {
        case .guest :       highlight(button: guestButton, size: 19.0)
        case .employee :    highlight(button: employeeButton, size: 19.0)
        case .vendor :      highlight(button: vendorButton, size: 19.0)
        case .manager :     highlight(button: managerButton, size: 19.0)
        case .contractor:   highlight(button: contractorButton, size: 19.0)
        }
        switch navigation.sub {
        case .freeChild:    highlight(button: childButton, size: 16.0)
        case .classic:    highlight(button: adultButton, size: 16.0)
        case .senior:   highlight(button: seniorButton, size: 16.0)
        case .vip:      highlight(button: vipButton, size: 16.0)
        case .foodService:    highlight(button: foodServiceButton, size: 16.0)
        case .rideService:    highlight(button: rideServiceButton, size: 16.0)
        case .manager :     highlight(button: managerButton, size: 19.0)
        case .maintenance:   highlight(button: maintenanceButton, size: 16.0)
        case .vendor :      highlight(button: vendorButton, size: 19.0)
            
        case .contractor:   highlight(button: contractorButton, size: 19.0)
            
        }
    }
    
    /*  } ---------------------- */

}





