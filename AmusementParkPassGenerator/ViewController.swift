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
        
        let manager = Entrant(.manager)
        let hourly = Entrant(.hourlyEmployeeFoodService)
        


        for discount in manager.discountAccess {
            print("\(discount)\n")
        }
        
        for discount in hourly.discountAccess {
            print("\(discount)\n")
        }
        
        for access in hourly.areaAccess {
            print("\(access)\n")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

