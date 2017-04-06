//
//  WHTestViewController.swift
//  WHScrollContentView
//
//  Created by Woodyhang on 17/4/5.
//  Copyright © 2017年 Woodyhang. All rights reserved.
//

import UIKit

class WHTestViewController: UIViewController {

    var tableView:UITableView!
    struct const {
        static var identifier = "cell"
    }
    
    var titleString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 124))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
     }
  
}

extension WHTestViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: const.identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: const.identifier)
        }
        cell?.textLabel?.text = titleString + "\(indexPath.row)" + "行"
        return cell!
    }
}
