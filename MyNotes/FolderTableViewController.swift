//
//  FolderTableViewController.swift
//  MyNotes
//
//  Created by sea on 16/9/20.
//  Copyright © 2016年 sea. All rights reserved.
//

import UIKit

class FolderTableViewController: UITableViewController {
    
    open var iad:String?
    //父级cell的数据
    open var folderData:FolderModel?
    fileprivate var data = [FileModel](){
        didSet{
            self.tableView.reloadData()
        }
    }
    let folderTable = FolderTable()
    let filelist  = FileList()
    @IBOutlet weak var navItem: UINavigationItem!
    
    struct myStoryBoard {
        static let folderCellIdentifier = "folderCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navItem.title = folderData?.title!
        self.tableView.backgroundColor = Tool.getBgColor(.A)
        self.getData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func getData() {
        self.data = folderTable.getFolderData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: 新建内容
    @IBAction func creatBtn(_ sender: UIButton) {
        let view:UIAlertController = UIAlertController.init(title: "新建内容", message: nil, preferredStyle: .alert)
        view.addTextField { (text) in
            text.placeholder = "文档名"
        }
        view.addTextField { (text) in
            text.placeholder = "链接地址"
        }
        view.addAction(UIAlertAction.init(title: "取消", style: .cancel))
        view.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
            let a = view.textFields?.first?.text!
            let b = view.textFields?[1].text!
            let cellData = FileModel(key: "", title: a!, cont: "", url: b!, fileTime: nil, updateTime: nil)
            self.creatFile(data: cellData)
        }))
         
        self.present(view, animated: true) { 
            
        }
    }
    //MARK: 新建file
    func creatFile(data:FileModel) {
       let temp = folderTable.addFolderData(data)
        if temp {
            Tool.log("添加成功！")
            self.getData()
            self.backgroundLoadHtml(str: data.url)
        }else{
            Tool.log("添加失败！")
        }
    }
    
    //MARK:后台下载网页内容
    func backgroundLoadHtml(str:String) {
       let temp = filelist.loadHtml(url: str)
        if temp {
            //如果网页内容下载成功 就把网页文件地址存到 folder数据表中
            
            Tool.log("asd")
        }
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myStoryBoard.folderCellIdentifier, for: indexPath) as! FolderTableViewCell
        cell.model = data[indexPath.row]
        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
