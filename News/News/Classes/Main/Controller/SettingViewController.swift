//
//  SettingViewController.swift
//  News
//
//  Created by liaoshen on 2020/5/15.
//  Copyright © 2020 liaoshen. All rights reserved.
//

import UIKit
import Kingfisher
class SettingViewController: UITableViewController {
    /// 存储 plist 文件中的数据
    var sections = [[SettingModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = sections[section]
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as SettingCell
        return cell
    }



}

extension SettingViewController {
    
}

extension SettingViewController {
    /// 设置 UI
    fileprivate func setupUI() {
        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
        for dicts in cellPlist {
            let array = dicts as! [[String: Any]]//数组里面放的是字典
            var rows = [SettingModel]()
            for dict in array {
                let setting = SettingModel.deserialize(from: dict as NSDictionary)
                rows.append(setting!)
            }
            sections.append(rows)
        }
        
        tableView.ym_registerCell(cell: SettingCell.self)
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        
    }
}
