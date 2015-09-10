//
//  ViewController.swift
//  XXYZoomTableViewHeader
//
//  Created by Xiaoxueyuan on 15/9/9.
//  Copyright (c) 2015年 Xiaoxueyuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let cellIdentify = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        var customView = UIView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2 - 50, 100, 100, 100))
        tableView.dataSource = self
        tableView.delegate = self
        customView.backgroundColor = UIColor.redColor()
        var headerView = XXYTableHeaderView(tableview: tableView, height: 300, image: UIImage(named: "3"), customTopView: customView)
        tableView.zoomHeaderView = headerView
        tableView.showBlurImageWhenScroll = true
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var segView = UISegmentedControl(items: ["按钮一","按钮二","按钮三"])
        segView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 40)
        segView.backgroundColor = UIColor.whiteColor()
        return segView
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify) as! UITableViewCell
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    deinit{
        println(__FUNCTION__)
    }
}

