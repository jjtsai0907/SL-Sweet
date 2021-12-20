//
//  TrafficCell.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-15.
//

import UIKit

class TrafficCell: UITableViewCell {

    @IBOutlet weak var cellMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellMessage.textColor = #colorLiteral(red: 1, green: 0.6, blue: 0.6, alpha: 1)
        
        
        backgroundColor = #colorLiteral(red: 1, green: 0.9215686275, blue: 0.8, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        //cellMessage.backgroundColor = .blue
        // Configure the view for the selected state
    }

}
