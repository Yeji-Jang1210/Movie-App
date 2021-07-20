//
//  MyTableViewCell.swift
//  MovieJYJ
//
//  Created by 소프트웨어컴퓨터 on 2021/05/24.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rankIntencnt: UILabel!
    @IBOutlet weak var rankIntenimg: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRank: UILabel!
    @IBOutlet weak var movAudiCnt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
