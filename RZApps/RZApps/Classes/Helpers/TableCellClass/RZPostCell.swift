//
//  RZPostCell.swift
//  RZApps
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/15/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit

class RZPostCell: UITableViewCell {
    
    @IBOutlet weak var cellPostTitle: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func ConfigurePostCell1 (rzPostModel: RZPostModel) {
        self.cellPostTitle.text = rzPostModel.post_title
    }
    
    func ConfigurePostCell (rzCorePost: RZPosts) {
        self.cellPostTitle.text = rzCorePost.posttitle
    }
}
