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
    
    @IBAction func checkAccessEngaged(_ sender: Any) {
        
        guard let button = sender as? UIButton else { return }
        
        switch button.tag {
        case 1:
            if entrant?.checkAccess(for: AreaAccess.office) == true {
                resultLabel.text = "Access granted for office area."
                makeResultsArea(color: .green)
            } else {
                resultLabel.text = "Access denied for office area."
                makeResultsArea(color: .red)
            }
        case 2:
            if entrant?.checkAccess(for: AreaAccess.kitchen) == true {
                resultLabel.text = "Access granted for kitchen area."
                makeResultsArea(color: .green)
            } else {
                resultLabel.text = "Access denied for kitchen area."
                makeResultsArea(color: .red)
            }
        case 3:
            if entrant?.checkAccess(for: AreaAccess.rideControl) == true {
                resultLabel.text = "Access granted for ride control area."
                makeResultsArea(color: .green)
            } else {
                resultLabel.text = "Access denied for ride control area."
                makeResultsArea(color: .red)
            }
        case 4:
            if entrant?.checkAccess(for: AreaAccess.amusement) == true {
                resultLabel.text = "Access granted for amusement area."
                makeResultsArea(color: .green)
            } else {
                resultLabel.text = "Access denied for amusement area."
                makeResultsArea(color: .red)
            }
        case 5:
            if entrant?.checkAccess(for: RideAccess.accessAllRides) == true {
                var output = "Pass grants access to all rides."
                if entrant?.checkAccess(for: RideAccess.skipAllLines) == true {
                    output += "\nPass is allowed to skip all lines."
                }
                makeResultsArea(color: .green)
                resultLabel.text = output
            } else {
                resultLabel.text = "Pass grants no access to rides."
                makeResultsArea(color: .red)
            }
        case 6: entrant?.checkAccess(for: AreaAccess.office)
        case 7: entrant?.checkAccess(for: AreaAccess.office)
        case 8: entrant?.checkAccess(for: AreaAccess.office)
        default: break
        }
    }
    
    
    var delegate: PassViewControllerDelegate! = nil
    
    enum resultsLabelColors {
        case green
        case red
    }
    
    func makeResultsArea(color: resultsLabelColors) {
        resultLabel.textColor = UIColor.white
        switch color {
        case .green: resultLabel.backgroundColor = UIColor(red: 141/255.0, green: 188/255.0, blue: 160/255.0, alpha: 1.0)
        case .red: resultLabel.backgroundColor = UIColor(red: 181/255.0, green: 106/255.0, blue: 117/255.0, alpha: 1.0)
            
        }
    }
    
    // This one seems empty even after segue
    var entrant: Entrant? = nil
    

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
                }
                
                if entrant.profile?.firstName == "" {
                    entrantNameLabel.text = "Anonymous"
                    print("nil=")
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
            case .vendor :  entrantTypeLabel.text = "Vendor Pass"
            }
            
            // Set entrant accesses for display
            var access: [String] = []
            
            if entrant.checkAccess(for: AreaAccess.amusement) {
                access.append("Access to amusements area.")
            }
            if entrant.checkAccess(for: AreaAccess.kitchen) {
                access.append("Can access the kitchen.")
            }
            if entrant.checkAccess(for: AreaAccess.maintenance) {
                access.append("Can access the maintenance areas.")
            }
            if entrant.checkAccess(for: AreaAccess.office) {
                access.append("Can access the office.")
            }
            if entrant.checkAccess(for: AreaAccess.rideControl) {
                access.append("Can access the ride-control area.")
            }
            if entrant.checkAccess(for: RideAccess.accessAllRides) {
                access.append("Access to all rides.")
            }
            if entrant.checkAccess(for: RideAccess.skipAllLines) {
                access.append("Can skip all lines.")
            }
            if entrant.checkAccess(for: DiscountAccess.discountOnFood10) {
                access.append("Has 10% discount on food.")
            }
            if entrant.checkAccess(for: DiscountAccess.discountOnFood15) {
                access.append("Has 15% discount on food.")
            }
            if entrant.checkAccess(for: DiscountAccess.discountOnFood20) {
                access.append("Has 20% discount on food.")
            }
            if entrant.checkAccess(for: DiscountAccess.discountOnFood25) {
                access.append("Has 25% discount on food.")
            }
            if entrant.checkAccess(for: DiscountAccess.discountOnMerchandise10) {
                access.append("Has 10% discount on merchandise.")
            }
            if entrant.checkAccess(for: DiscountAccess.discountOnMerchandise15) {
                access.append("Has 20% discount on merchandise.")
            }
            if entrant.checkAccess(for: DiscountAccess.discountOnMerchandise20) {
                access.append("Has 15% discount on merchandise.")
            }
            if entrant.checkAccess(for: DiscountAccess.discountOnMerchandise25) {
                access.append("Has 25% discount on merchandise.")
            }
            
            
            entrantPermissionsLabel.text = access.joined(separator: "\n")
            entrantPermissionsLabel.sizeToFit()
        }
        else { entrantNameLabel.text = "Anonymous" }
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
