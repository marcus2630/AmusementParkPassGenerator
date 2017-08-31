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
        
        var access: (access: Bool, message: String) = (false, "Couldn't check access for the specified criteria.")
        
        if let entrant = entrant {
        
            switch button.tag {
                case 1: access = entrant.checkAccess(for: AreaAccess.office)
                case 2: access = entrant.checkAccess(for: AreaAccess.kitchen)
                case 3: access = entrant.checkAccess(for: AreaAccess.rideControl)
                case 4: access = entrant.checkAccess(for: AreaAccess.amusement)
                case 5: access = entrant.checkAccess(for: RideAccess.accessAllRides)
                case 6: access = entrant.checkAccess(for: entrant.discountAccess)
                case 7: access = entrant.checkAccess(for: entrant.discountAccess)
                case 8: access = entrant.checkAccess(for: AreaAccess.maintenance)
        
                default: break
            }
        }
        if access.access == true { makeResultsArea(color: .green) }
        else { makeResultsArea(color: .red) }
        
        resultLabel.text = access.message
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
            let description: String = ""
            
            entrantPermissionsLabel.text = description
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
