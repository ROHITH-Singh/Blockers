//
//  MyTableViewCell.swift
//  Blockers
//
//  Created by Rohit on 15/05/21.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ImageLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
