//
//  ViewController.swift
//  WishList
//
//  Created by 김태균 on 2021/05/26.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
//    var wishes:[WishList] = []
        
    @IBOutlet var tableView: UITableView!
        
    private var wishes = [WishList]() {
        didSet { tableView.reloadData() }
    }
    
    private let wishData = DataBaseHelper.shareInstance
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.title = "Wish List"
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
                
        configureData()
//        CoreDataHandler.cleanDelete()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    // MARK: - Helpers
    
    func configureData() {
        wishData.getAllList()
        do { DispatchQueue.main.async {
            self.tableView.reloadData()
        }}
    }
    
    // MARK: - Actions
    
    @objc private func didPullToRefresh() {
        print("start refresh")
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.tableView.refreshControl?.endRefreshing()
            self.configureData()
        }
    }
    
//    https://www.youtube.com/watch?v=8Q5Utz68P8g
    
    @IBAction func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "add") as! AddViewController
        vc.title = "Add Item"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            wishData.deleteItem(item: wishData.models[indexPath.row])
            wishData.models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}

// MARK: - ViewControllerDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "edit") as! EditViewController
        vc.title = "Edit Item"
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - ViewControllerDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishData.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let model = wishData.models[indexPath.row]
       
        cell.nameField.text = model.name
        cell.priceField.text = String(model.price)
        cell.selectionStyle = .none
        cell.photoImageView.image = UIImage(data: model.img!)
        cell.photoImageView.contentMode = .scaleAspectFill
        return cell
    }
}
