//
//  HomeNewsTitle.swift
//  News
//
//  Created by liaoshen on 2020/5/8.
//  Copyright © 2020 liaoshen. All rights reserved.
//

import Foundation
import HandyJSON

struct  HomeNewsTitle: HandyJSON {
    var category: String = ""
    var tip_new: Int = 0
    var default_add: Int = 0
    var web_url: String = ""
    var concern_id: String = ""
    var icon_url: String = ""
    var flags: Int = 0
    var type: Int = 0
    var name: String = ""
    
    var selected: Bool = true
}
