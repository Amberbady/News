//
//  MyNavigationController.swift
//  News
//
//  Created by liaoshen on 2020/5/7.
//  Copyright © 2020 liaoshen. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = UINavigationBar.appearance()
        navigationBar.theme_barTintColor = "colors.cellBackgroundColor"
        navigationBar.theme_tintColor = "colors.black"
        // 全局拖拽手势
        initGlobalPan()
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
       
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    @objc private func navigationBack() {
        popViewController(animated: true)
    }

}


extension MyNavigationController: UIGestureRecognizerDelegate {
    /// 全局拖拽手势
    fileprivate func initGlobalPan() {
        // 创建 pan 手势
        let target = interactivePopGestureRecognizer?.delegate
        let globalPan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        globalPan.delegate = self
        view.addGestureRecognizer(globalPan)
        // 禁止系统的手势
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count != 1
    }
    
}
