//
//  WinnersTableViewCell.swift
//  KingFaisalPrice
//
//  Created by Apple on 12/14/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit

class WinnersTableViewCell: UITableViewCell {

    
    @IBOutlet weak var winnerImage: UIImageView!
    @IBOutlet weak var winnerName: UILabel!
    @IBOutlet weak var winnerType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
