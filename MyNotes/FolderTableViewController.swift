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
            Tool.log("tableVewData:=\(data)")
            self.tableView.reloadData()
        }
    }
    let folderTable = FolderTable()
    let http = HttpTool()
    let fileManager = FileManage()
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    struct myStoryBoard {
        static let folderCellIdentifier = "folderCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navItem.title = folderData?.title!
        self.tableView.backgroundColor = Tool.getBgColor(.A)
        self.getData(parent: (folderData?.key)!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func getData(parent:String) {
        self.data = folderTable.getFolderData(parent: parent)
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
            let cellData = FileModel(key: "", title: a!, cont: "", url: b!, fileTime: nil, updateTime: nil,parentId:(self.folderData?.key)!,remark: "")
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
            self.getData(parent: (folderData?.key)!)
            // 把当前的文件 查询出来 得到key
            let modeData = folderTable.getTagetFolderData(mode: data)
            if modeData.count > 0 {
                self.backgroundLoadHtml(mode: modeData[0])
            }
            
        }else{
            Tool.log("添加失败！")
        }
    }
    

    //MARK:后台下载网页内容
    func backgroundLoadHtml(mode:FileModel) {
        http.requestWithUrl(type: .get, url: mode.url, parameters: nil, success: {(data) in
            let path = self.fileManager.creatHtmlFile(name: mode.url, data: (data as! String))
            if path != nil {
                Tool.log("创建成功")
                
                var modea = mode
                modea.cont = path!
                Tool.log(modea.cont)
                if self.folderTable.updateFolderData(modea){
                    Tool.log("数据更新成功")
                    
                }else{
                    Tool.log("数据更新失败")
                }
            }
        }) { (e) in
            Tool.log(e)
            
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
 
    //MARK:删除cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            //执行删除数据
            let cell = tableView.cellForRow(at: indexPath) as! FolderTableViewCell
            if  folderTable.deleteFolderData((cell.model?.key)!){
                getData(parent: (folderData?.key)!)
            }
            
        }
    }
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
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

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fileList" {
            let vc = segue.destination as! FileViewController
            let cell = tableView(tableView, cellForRowAt: tableView.indexPathForSelectedRow!)
            vc.fileData = (cell as! FolderTableViewCell).model!
        }
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == "fileList" {
//            
//        }
//        return true
//    }
 

}
