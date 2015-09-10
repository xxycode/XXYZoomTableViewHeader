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
    private weak var customView:UIView?
    private var deltScale = CGFloat(0.5)
    private let observerKeyPath = "contentOffset"
    private var observerContext = 0
    private var customViewOriginY:CGFloat?
    private var blurImageView:UIImageView?
    private var isObservered = false
    var showBlurImageWhenScroll = false{
        didSet{
            if showBlurImageWhenScroll {
                loadBlurView()
            }
        }
    }
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
        addObservers()
        headerContentView.frame = CGRectMake(0, topOffset, width, height - topOffset)
        imageView.frame = headerContentView.bounds
        addSubview(headerContentView)
        headerContentView.clipsToBounds = true
    }
    
    func tableViewDidScroll(){
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
            blurImageView?.alpha = process
            imageView.transform = CGAffineTransformMakeScale(zoomScale, zoomScale)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == observerKeyPath{
            tableViewDidScroll()
        }
    }
    
    func loadBlurView(){
        if imageView.image == nil{
            return
        }
        if blurImageView == nil{
            blurImageView = UIImageView(frame: imageView.frame)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
                var img = self.imageView.image!.applyBlurWithRadius(30, tintColor: UIColor(white: 0.2, alpha: 0.2), saturationDeltaFactor: 1.8)
                dispatch_async(dispatch_get_main_queue(), {
                    self.blurImageView?.image = img
                })
            })
            headerContentView.insertSubview(blurImageView!, aboveSubview: imageView)
            blurImageView?.alpha = 0
        }
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        removeObservers()
        super.willMoveToSuperview(newSuperview)
        
    }
    
    func addObservers(){
        isObservered = true
        associatedTableView?.addObserver(self, forKeyPath: observerKeyPath, options: NSKeyValueObservingOptions.New, context: &observerContext)
    }
    
    func removeObservers(){
        if isObservered{
            superview!.removeObserver(self, forKeyPath: observerKeyPath, context: &observerContext)
            isObservered = false
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



