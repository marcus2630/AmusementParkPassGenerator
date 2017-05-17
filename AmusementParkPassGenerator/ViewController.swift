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
        
        do {
            let _ =  try Employee(as: .manager, withInformation: .init(employeeWithFirstName: "", lastName: "Klausen", street: "Østergården 20", city: "Copenhagen", state: "Sjælland", zip: 2635))
        } catch EmployeeError.InvalidData(let data) {
            print("Error, profile for was missing \(data)")
        } catch let error {
            print("Other error occured- \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

