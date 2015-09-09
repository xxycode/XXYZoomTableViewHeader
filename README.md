带视差的tableHeaderView，使用方便，支持集成下拉刷新控件
给tableView做了一个extension，使用起来很简单

    var customView = UIView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2 - 50, 100, 100, 100))
    tableView.zoomHeaderView = XXYTableHeaderView(tableview: tableView, height: 300, image: UIImage(named: "3"),  customTopView: customView)

一句话就加上了，customTopView这个参数是可以让你添加自定义的额外的View
效果如下

 ![效果图](https://github.com/xxycode/XXYZoomTableViewHeader/blob/master/2015-09-09%2022_52_30.gif)
