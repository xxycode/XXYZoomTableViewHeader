//
//  UITableViewZoomHeaderExtension.swift
//  XXYZoomTableViewHeader
//
//  Created by Xiaoxueyuan on 15/9/9.
//  Copyright (c) 2015年 Xiaoxueyuan. All rights reserved.
//

import UIKit
extension UITableView{
    private struct AssociatedKeys {
        static var DescriptiveName = "XXYTableHeaderView"
    }
    var zoomHeaderView:XXYTableHeaderView?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? XXYTableHeaderView
        }
        set{
            if let newValue = newValue{
                willChangeValueForKey("zoomHeaderView")
                objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue as XXYTableHeaderView?, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
                didChangeValueForKey("zoomHeaderView")
            }
        }
    }
}
