//
//  MyTabBarController.swift
//  News
//
//  Created by liaoshen on 2020/5/7.
//  Copyright © 2020 liaoshen. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print(tabBar.subviews)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor(red: 245 / 255.0, green: 90 / 255.0, blue: 93 / 255.0, alpha: 1.0)
        addChildViewControllers()
    }
    
    ///添加子控制器
    func addChildViewControllers(){
        setChildViewController(HomeViewController(), title: "首页", imageName: "home_tabbar_32x32_", selectImageName: "home_tabbar_press_32x32_")
        setChildViewController(VideoViewController(), title: "视频", imageName: "video_tabbar_32x32_", selectImageName: "video_tabbar_press_32x32_")
        setChildViewController(HuoshanViewController(), title: "小视频", imageName: "huoshan_tabbar_32x32_", selectImageName: "huoshan_tabbar_press_32x32_")
        setChildViewController(MineViewController(), title: "我的", imageName: "mine_tabbar_32x32_", selectImageName: "mine_tabbar_press_32x32_")
        // tabBar 是 readonly 属性，不能直接修改，利用 KVC 把 readonly 属性的权限改过来
        setValue(MyTabBar(), forKey: "tabBar")
    }
    
    //初始化控制器
    func setChildViewController(_ childController: UIViewController,title: String,imageName: String,selectImageName: String) {
        //设置tabbar文字和图片
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectImageName)
        childController.title = title
        let navVc = MyNavigationController(rootViewController: childController)
        addChild(navVc)
    }
    

}
