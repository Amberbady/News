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
        // 从沙盒中获取缓存数据的大小
        calculateDiskCashSize()
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
        let rows = sections[indexPath.section]
        cell.setting = rows[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension SettingViewController {
    /// 从沙盒中获取缓存数据的大小
    fileprivate func calculateDiskCashSize() {
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (size) in
            // 转换成 M
            let sizeM = Double(size) / 1024.0 / 1024.0
            let sizeString = String(format: "%.2fM", sizeM)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cacheSizeM"), object: self, userInfo: ["cacheSize": sizeString])
        }
    
    }
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
