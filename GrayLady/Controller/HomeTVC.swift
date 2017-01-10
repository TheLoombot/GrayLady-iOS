//
//  HomeTVC.swift
//  Gray Lady
//
//  Created by David on 1/6/17.
//  Copyright © 2017 QTScoder. All rights reserved.
//

import UIKit
import Contentful

class HomeTVC: UITableViewController {

    var arrayData = [Entry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        let refeshController = UIRefreshControl()
        refeshController.setText()
        refeshController.addTarget(self, action: #selector(hanleRefresh), for: .valueChanged)
        self.refreshControl = refeshController
        hanleRefresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func hanleRefresh(){
        refreshControl?.setTextRefreshing()
        ManageContentful.sharedInstance.getEntryTypeBriefing { (arr) in
            if let arr = arr {
                self.arrayData = arr
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    OperationQueue.current?.addOperation({
                        self.refreshControl?.endRefreshing()
                        self.refreshControl?.setText()
                    })


                }

            }else {
                print("error")
                OperationQueue.current?.addOperation({
                    self.refreshControl?.endRefreshing()
                    self.refreshControl?.setText()
                })

            }
        }

    }

    func demodata() {

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "Cell")
        let entry = arrayData[indexPath.row]

        cell.textLabel?.text = ManageContentful.sharedInstance.getTitleAndAuthor(entry).title
        cell.textLabel?.font = UIFont().fontApp(15)
        cell.detailTextLabel?.text = ManageContentful.sharedInstance.getTitleAndAuthor(entry).author
        cell.detailTextLabel?.font = UIFont().fontApp(10)
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailPieceVC(entry: arrayData[indexPath.row])
        navigationController?.pushViewController(detail, animated: true)
        
    }
    
    
}