//
//  TableViewCell.swift
//  Dailly_Challenge_SearchView
//
//  Created by Hertz on 9/14/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    // Cell 아이덴티파이어
    static let identifier = "TableViewCell"
    // 라벨 접근요소
    @IBOutlet weak var popularSearchTermLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for. the selected state
    }
    
    
    
}
