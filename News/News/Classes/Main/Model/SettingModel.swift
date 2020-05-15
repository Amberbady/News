//
//  SettingModel.swift
//  News
//
//  Created by liaoshen on 2020/5/15.
//  Copyright © 2020 liaoshen. All rights reserved.
//

import Foundation
import HandyJSON

struct SettingModel: HandyJSON {
    var title: String = ""
    var subtitle: String = ""
    var rightTitle: String = ""
    var isHiddenSubtitle: Bool = false
    var isHiddenRightTitle: Bool = false
    var isHiddenSwitch: Bool = false
    var isHiddenRightArraw: Bool = false
}
