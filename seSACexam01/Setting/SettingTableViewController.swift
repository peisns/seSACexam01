//
//  SettingTableViewController.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    static let identifier = "SettingTableViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "설정"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        
        return 3
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Username", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: UsernameViewController.identifier) as? UsernameViewController else {
        showAlert(message: "잘못된 스토리보드입니다")
        return }
        navigationController?.pushViewController(vc, animated: true)
    }

}
