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
        
        let manager = Guest(.classicGuest, profile: Profile(firstName: "Marcus", lastName: "Klausen", streetAddress: "Østergården 20", city: "Ishøj", state: "København", zipCode: 2630, birthday: nil))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

