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
        
        
        // Creating employee (manager) instance with profile
        do {
            let manager = try Employee(as: .manager, withInformation: .init(employeeWithFirstName: "Martin", lastName: "Enghave", street: "Wonderstreet", city: "Taastrup", state: "Copenhagen", zip: 1620))
        } catch ProfileError.InvalidData(let description) {
            print("\(description)")
        } catch let error {
            print("Something else went wrong")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

