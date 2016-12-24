//
//  EmployeeCell.swift
//  HRiOS
//
//  Created by MAC on 2016-12-05.
//  Copyright © 2016 MAC. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var txtCountry: UILabel!

//    @IBOutlet weak var txtType: UILabel!
    @IBOutlet weak var txtVal1: UILabel!
    @IBOutlet weak var txtVal2: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
