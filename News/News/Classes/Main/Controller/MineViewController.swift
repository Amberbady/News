//
//  MineViewController.swift
//  News
//
//  Created by liaoshen on 2020/5/7.
//  Copyright © 2020 liaoshen. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class MineViewController: UITableViewController {
    fileprivate let disposeBag = DisposeBag()
    var sections = [[MyCellModel]]()
    // 存储我的关注数据
    var concerns = [MyConcern]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.separatorStyle = .none
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        tableView.tableHeaderView = headerView
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
                let indextSet = IndexSet(integer: 0)
                self.tableView.reloadSections(indextSet, with: .automatic)
            }
        }
        
        headerView.moreLoginButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            let storyboard = UIStoryboard(name: String(describing: MoreLoginViewController.self), bundle: nil)
            let moreLoginVC = storyboard.instantiateViewController(identifier: String(describing: MoreLoginViewController.self)) as! MoreLoginViewController
            moreLoginVC.modalSize = (width: .full, height: .custom(size: Float(screenHeight - (isIPhoneX ? 44 : 20))))
            self!.present(moreLoginVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate lazy var headerView: NoLoginHeaderView = {
        let headerView = NoLoginHeaderView.headerView()
        return headerView
    }()
    
    //设置状态栏白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
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
            cell.myCellModel = section[indexPath.row]
            if concerns.count == 0 || concerns.count == 1{
                cell.collectionView.isHidden = true
            }
            if concerns.count == 1 {
                cell.myConcern = concerns[0]
            }
            
            if concerns.count > 1 {
                cell.myConcerns = concerns
            }
//            cell.delegate = self as! MyFisrtSectionCellDelegate
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let totalOffset = kMyHeaderViewHeight + abs(offsetY)
            let f = totalOffset / kMyHeaderViewHeight
            headerView.bgImageView.frame = CGRect(x: -screenWidth * (f - 1) * 0.5, y: offsetY, width: screenWidth * f, height: totalOffset)
        }
    }
}
