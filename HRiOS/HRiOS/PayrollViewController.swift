//
//  PayrollViewController.swift
//  HRiOS
//
//  Created by MAC on 2016-12-12.
//  Copyright © 2016 MAC. All rights reserved.
//

import UIKit

class PayrollViewController: UIViewController {
    @IBOutlet weak var txtPayroll: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        var earn = 0
        var totalPR = 0
        var result : String = ""
        
        for em in arrEmployee{
            result += "\n------------------------------------------------------------\n"
            
            result += em.toString()
            earn = em.calcEarnings()
            result += "\nEarnings: \(earn)"
            totalPR += earn
            
            print ("******************************")
            em.displayData()
            print ("******************************")
            print ("Earnings: \(earn)")
        }
        result += "\n=========================================="
        result += "\nTotal Payroll: \(totalPR)"
        print ("Total Payroll: \(totalPR)")
        
        txtPayroll.text = result
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
