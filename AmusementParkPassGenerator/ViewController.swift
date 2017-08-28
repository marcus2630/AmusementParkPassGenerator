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
    case guest, employee, manager, vendor
}

enum SubNavigation {
        // Guest
        case child, adult, senior, vip
    
        // Employee
        case foodService, rideService, maintenance
}

// Navigation Model
class Navigation {
    var main: MainNavigation
    var sub: EntrantType
    
    init(mainNavigation: MainNavigation, subNavigation: EntrantType) {
        self.main = mainNavigation
        self.sub = subNavigation
    }
}

// Create instance
let navigation = Navigation(mainNavigation: .guest, subNavigation: .freeChild)


class ViewController: UIViewController, PassViewControllerDelegate {
    
    // Outlets for the sub navigations for show/hide functionality
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
    
    // Form outlets
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var ssn: UITextField!
    @IBOutlet weak var project: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    
    
    // Declared entrant to avoid scope issues
    var entrant: Entrant? = nil
    
    @IBAction func generatePassAndSegue(_ sender: Any) {
        
        
            do {
                var zipCodeAsInt: Int? = nil
                
                if let zipCodeText = zipCode.text {
                    zipCodeAsInt = Int(zipCodeText)
                }
                
                
                if navigation.main == .employee {
                    let profile = Profile(employeeWithFirstName: firstName.text, lastName: lastName.text, street: streetAddress.text, city: city.text, state: state.text, zip: zipCodeAsInt)
                    entrant = try Entrant(as: navigation.sub, withInformation: profile)
                }
                
                if navigation.main == .guest {
                    if navigation.sub == .freeChild {
                        let profile = Profile(freeChildWithBirthday: dateOfBirth.text)
                        entrant = try Entrant(as: navigation.sub, withInformation: profile)
                    } else {
                        let profile = Profile(firstName: firstName.text, lastName: lastName.text, street: streetAddress.text, city: city.text, state: state.text, zip: zipCodeAsInt, birthday: dateOfBirth.text)
                        entrant = try Entrant(as: navigation.sub, withInformation: profile)
                    }
                    
                }
                
                if entrant != nil {
                    performSegue(withIdentifier: "GeneratePass", sender: entrant)
                }
                
                print("\(String(describing: entrant?.profile?.firstName)) was created successfully")
                
            } catch ProfileError.InvalidData(let data) {
                let message = "Please fill in the \(data), before generating a pass."
                let alert = UIAlertController(title: "Missing information", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,
                                              handler: nil))
                present(alert, animated: true, completion: nil)
                
            } catch {
                print("Other error occured")
            }
        
    }
    
    
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
    
    
    @IBAction func tapNavigationButton(_ sender: Any) {
        
        
        guard let button = sender as? UIButton else { return }
        
        switch button.tag {
        
        // Main menu
        case 1: navigation.main = .guest
            
        case 2: navigation.main = .employee
            
        case 3: navigation.main = .manager
        case 4: navigation.main = .vendor
            
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
        
        highlightRequiredInputFields()
        layoutSubNavigation()
        updateButtonStyles()
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
        }
        
        
    }
    
    func highlightRequiredInputFields() {
        
        dateOfBirth.backgroundColor = UIColor.clear
        ssn.backgroundColor = UIColor.clear
        firstName.backgroundColor = UIColor.clear
        lastName.backgroundColor = UIColor.clear
        company.backgroundColor = UIColor.clear
        project.backgroundColor = UIColor.clear
        streetAddress.backgroundColor = UIColor.clear
        city.backgroundColor = UIColor.clear
        state.backgroundColor = UIColor.clear
        zipCode.backgroundColor = UIColor.clear
        
        
        if navigation.main == .employee {
            dateOfBirth.backgroundColor = UIColor.white
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
        switch navigation.main {
        case .guest :       highlight(button: guestButton, size: 19.0)
        case .employee :    highlight(button: employeeButton, size: 19.0)
        case .vendor :      highlight(button: vendorButton, size: 19.0)
        case .manager :     highlight(button: managerButton, size: 19.0)
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
        }
    }


    var navigationButtons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myRect = CGRect(x: 10, y: 0, width: 30, height: 30)
        dateOfBirth.textRect(forBounds: myRect)
        dateOfBirth.placeholderRect(forBounds: myRect)
        
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
        highlightRequiredInputFields()
        

        
   
    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

