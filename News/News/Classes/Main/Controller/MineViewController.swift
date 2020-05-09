//
//  MineViewController.swift
//  News
//
//  Created by liaoshen on 2020/5/7.
//  Copyright © 2020 liaoshen. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {

    var sections = [[MyCellModel]]()
    // 存储我的关注数据
    var concerns = [MyConcern]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        
        tableView.ym_registerCell(cell: MyFisrtSectionCell.self)
        tableView.ym_registerCell(cell: MyOtherCell.self)
       
        NetworkTool.loadMyCellData { (sections) in
            let jsonString = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: jsonString)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.sections.append(myConcerns)
            self.sections += sections
            self.tableView.reloadData()
            
            NetworkTool.loadMyConcern { (concerns) in
                self.concerns = concerns
            }
        }
    }

}

extension MineViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns.count == 0 || concerns.count == 1) ? 40 : 114
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 60))
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as MyFisrtSectionCell
            let section = sections[indexPath.section]
            let myCellModel = section[indexPath.row]
            cell.leftLabel?.text = myCellModel.text
            cell.rightLabel?.text = myCellModel.grey_text
            return cell
        }
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath)  as MyOtherCell
        let section = sections[indexPath.section]
        let myCellModel = section[indexPath.row]
        cell.leftLabel?.text = myCellModel.text
        cell.rightLabel?.text = myCellModel.grey_text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
