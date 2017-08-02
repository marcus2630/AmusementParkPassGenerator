//
//  PassViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Marcus Klausen on 03/07/2017.
//  Copyright © 2017 Marcus Klausen. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    

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
