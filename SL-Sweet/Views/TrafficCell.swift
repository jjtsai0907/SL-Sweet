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
        cellMessage.textColor = .red
        backgroundColor = .blue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        //cellMessage.backgroundColor = .blue
        // Configure the view for the selected state
    }

}
