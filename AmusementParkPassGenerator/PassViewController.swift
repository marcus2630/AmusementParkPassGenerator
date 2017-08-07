//
//  PassViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 03/07/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import UIKit

protocol PassViewControllerDelegate {}

class PassViewController: UIViewController {
    
    
    @IBOutlet weak var entrantNameLabel: UILabel!
    @IBOutlet weak var entrantTypeLabel: UILabel!
    @IBOutlet weak var entrantPermissionsLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
    var delegate: PassViewControllerDelegate! = nil
    
    
    // This one seems empty even after segue
    var entrant: Guest? = nil
    

    @IBAction func createNewPass(_ sender: Any) {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let resultLabelColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 0.6)
        resultLabel.layer.borderColor = resultLabelColor.cgColor
        resultLabel.layer.cornerRadius = 4
        resultLabel.clipsToBounds = true
        resultLabel.layer.borderWidth = 1
        
        // entrant is empty
        if let entrant = entrant {
        
            
            // Set profile information for display if added
            if let profile = entrant.profile {
                
                if let firstName = profile.firstName {
                    entrantNameLabel.text = firstName
                    
                    if let lastName = profile.lastName {
                        entrantNameLabel.text! += " \(lastName)"
                    }
                } else if profile.firstName == "" && profile.lastName == "" {
                    entrantNameLabel.text = "Anonymous"
                }
            }
            
            // Set entrant type for display
            switch entrant.type {
            case .classic: entrantTypeLabel.text = "Classic Guest Pass"
            case .foodService: entrantTypeLabel.text = "Food Service Employee Pass"
            case .freeChild: entrantTypeLabel.text = "Child Guest Pass"
            case .maintenance: entrantTypeLabel.text = "Maintenance Employee Pass"
            case .manager: entrantTypeLabel.text = "Manager Pass"
            case .rideService: entrantTypeLabel.text = "Ride Service Employee Pass"
            case .senior: entrantTypeLabel.text = "Senior Guest Pass"
            case .vip: entrantTypeLabel.text = "VIP Guest Pass"
            }
            
            // Set entrant accesses for display
            var access: [String] = []
            
            if entrant.checkAccess(for: AreaAccess.amusement) {
                access.append("Access to amusements.")
            }
            if entrant.checkAccess(for: RideAccess.accessAllRides) {
                access.append("Access to all rides.")
            }
            if entrant.checkAccess(for: RideAccess.skipAllLines) {
                access.append("Can skip all lines.")
            }
            
            entrantPermissionsLabel.text = access.joined(separator: "\n")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
