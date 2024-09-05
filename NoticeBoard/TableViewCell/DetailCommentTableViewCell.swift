//
//  DetailCommentTableViewCell.swift
//  NoticeBoard
//
//  Created by 준수김 on 9/2/24.
//

import UIKit

class DetailCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
