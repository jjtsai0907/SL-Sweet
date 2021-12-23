//
//  RealtimeTableCell.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-23.
//

import UIKit

class RealtimeTableCell: UITableViewCell {

    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
