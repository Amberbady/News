//
//  NetworkTool.swift
//  News
//
//  Created by liaoshen on 2020/5/8.
//  Copyright © 2020 liaoshen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocol {
    //首页顶部新闻标题数据
//    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())
    //我的界面cell 数据
    static func loadMyCellData(completionHandler: @escaping (_ sections:[[MyCellModel]]) -> ())
    //我的关注
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ())
}

extension NetworkToolProtocol {
   
    
    static func loadMyCellData(completionHandler: @escaping (_ sections:[[MyCellModel]]) -> ()){
        let url = BASE_URL + "/user/tab/tabs/?"
        let params = ["device_id":device_id]
        Alamofire.request(url,parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                // 网络错误的提示信息
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    print(data)
                    if let sections = data["sections"]?.array {
                        var sectionArray = [[MyCellModel]]()
                        for item in sections {
                            var rows = [MyCellModel]()
                            for row in item.arrayObject! {
                                let myCellModel = MyCellModel.deserialize(from: row as? NSDictionary)
                                rows.append(myCellModel!)
                            }
                            sectionArray.append(rows)
                        }
                        completionHandler(sectionArray)
                    }
                }
            }
        }
        
    }
    
    //我的关注
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ()){
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id": device_id]
        Alamofire.request(url,parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                // 网络错误的提示信息
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let datas = json["data"].arrayObject {
                    var concserns = [MyConcern]()
                    for data in datas {
                        let myCellModel = MyConcern.deserialize(from: data as? NSDictionary)
                        concserns.append(myCellModel!)
                    }
                    completionHandler(concserns)
                }
            }
        }
    }
}

struct NetworkTool:  NetworkToolProtocol{
    
}
