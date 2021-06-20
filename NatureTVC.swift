//
//  NatureTVC.swift
//  KalemProject
//
//  Created by Dzaki Izza on 29/04/21.
//

import UIKit

class NatureTVC: UITableViewCell {

    @IBOutlet weak var natureView: UIView!
    @IBOutlet weak var natureImageView: UIImageView!
    @IBOutlet weak var natureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
