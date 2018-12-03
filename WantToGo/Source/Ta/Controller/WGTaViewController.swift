//
//  TaViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/27.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGTaViewController: WGTableViewController {

    var discoverModelArray = NSArray() {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = KBackgroudColor
        self.tableView?.backgroundColor = KBackgroudColor
        self.loadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.discoverModelArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "WGTaDiscoverCell")
        if cell == nil {
            cell = WGTaDiscoverCell.init(style: .default, reuseIdentifier: "WGTaDiscoverCell")
        }
        
        if indexPath.row < self.discoverModelArray.count {
            let discoverDataModel = self.discoverModelArray.object(at: indexPath.row) as! WGTaDiscoverDataModel
            
          (cell as! WGTaDiscoverCell).loadUI(model: discoverDataModel)
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 430
    }
    
    
    func loadData() -> Void {
     
        let dict = NSMutableDictionary()
        dict.setValue("0", forKey: "page")
        NetworkRequest(.taDiscoverApi(Dict: dict as! [String : Any])){ (respose) -> (Void) in
            
            if let discoverModel = WGTaDiscoverModel.deserialize(from: respose){
                if discoverModel.code == SuccessCode {
                    self.discoverModelArray = discoverModel.data! as NSArray
                }
            }
        }
        
    }
    
}
