//
//  XXYTableHeaderView.swift
//  XXYZoomTableViewHeader
//
//  Created by Xiaoxueyuan on 15/9/9.
//  Copyright (c) 2015年 Xiaoxueyuan. All rights reserved.
//

import UIKit

class XXYTableHeaderView: UIView {
    
    private weak var associatedTableView:UITableView?
    private var headerContentView = UIView()
    private var imageView = UIImageView()
    private var customView:UIView?
    private var deltScale = CGFloat(0.5)
    private let observerKeyPath = "contentOffset"
    private var observerContext = 0
    private var customViewOriginY:CGFloat?
    var topOffset = -CGFloat(200){
        didSet{
            customView?.y -= topOffset
            customViewOriginY = customView?.y
        }
    }
    var maxZoomScale = CGFloat(1.5){
        didSet{
            deltScale = maxZoomScale - 1
        }
    }
    var maxPullDistance = CGFloat(170)
    
    
    
    init(tableview:UITableView,height:CGFloat,image:UIImage?,customTopView:UIView?){
        super.init(frame: CGRectMake(0, 0, tableview.width, height))
        associatedTableView = tableview
        imageView.image = image
        customViewOriginY = 0
        headerContentView.addSubview(imageView)
        if customTopView != nil{
            customView = customTopView!
            headerContentView.addSubview(customView!)
        }
        layoutCustomViews()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func layoutCustomViews(){
        associatedTableView?.layoutIfNeeded()
        topOffset = -200
        associatedTableView?.tableHeaderView = self
        associatedTableView?.addObserver(self, forKeyPath: observerKeyPath, options: NSKeyValueObservingOptions.New, context: &observerContext)
        headerContentView.frame = CGRectMake(0, topOffset, width, height - topOffset)
        imageView.frame = headerContentView.bounds
        addSubview(headerContentView)
        
        headerContentView.clipsToBounds = true
    }
    
    func tableViewDidScroll(){
        println(imageView.width)
        var offSet_y = associatedTableView!.contentOffset.y
        if offSet_y >= 0{
            imageView.y = offSet_y/3
            customView?.y = customViewOriginY! + offSet_y/4
            
        }else{
            var process = -CGFloat(offSet_y/maxPullDistance)
            if process > 1{
                process = 1
            }
            var zoomScale = CGFloat(1) + deltScale * process
            imageView.transform = CGAffineTransformMakeScale(zoomScale, zoomScale)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == observerKeyPath{
            tableViewDidScroll()
        }
    }
}

extension UIView{
    var x:CGFloat{
        get{
            return frame.origin.x
        }
        set{
            var f = frame
            f.origin.x = newValue
            frame = f
        }
    }
    var y:CGFloat{
        get{
            return frame.origin.y
        }
        set{
            var f = frame
            f.origin.y = newValue
            frame = f
        }
    }
    var width:CGFloat{
        get{
            return frame.size.width
        }
        set{
            var f = frame
            f.size.width = newValue
            frame = f
        }
    }
    var height:CGFloat{
        get{
            return frame.size.height
        }
        set{
            var f = frame
            f.size.height = newValue
            frame = f
        }
    }
}


