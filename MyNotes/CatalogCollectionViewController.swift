//
//  RootCollectionViewController.swift
//  MyNotes
//
//  Created by sea on 16/9/19.
//  Copyright © 2016年 sea. All rights reserved.
//

import UIKit


private let reuseIdentifier = "Cell"

class CatalogCollectionViewController: UICollectionViewController,UIGestureRecognizerDelegate {

    //数据原
    var data = Array<FolderModel>(){
        didSet{
            //添加 默认的按钮的那个数据
            data.append(FolderModel(key: "", title: "默认", bg: "bg", childer: nil, time: nil))
            self.collectionView?.reloadData()
        }
    }
    // cell的状态有2种 正常和 删除状态
    enum cellState:String{
        case nomale   //正常状态
        case delete   //删除状态
    }
    //cell的当前状态 默认是正常状态
    var cellStating:cellState = .nomale{
        didSet{
            
        }
    }
    
    let catalog = Catalog()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFolderData()
        
        self.collectionView?.backgroundColor = Tool.getBgColor(.A)
        addGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //获取当前用户的文件夹列表
    func getFolderData(){
       self.data = catalog.getFolderData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CatalogCollectionViewCell
        let cellData = self.data[indexPath.row]
        cell.dataModel = cellData
        cell.cellIndex = indexPath.row

        if indexPath.row == data.count-1 {
            cell.setCellStyle(.cellDefault)
        }else{
             cell.setCellStyle(.cellCustom)
        }
       
    
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    //MARK:cell被点击
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
       // let index = (collectionView.cellForItem(at: indexPath) as! CatalogCollectionViewCell).cellIndex
        let cell = collectionView.cellForItem(at: indexPath) as! CatalogCollectionViewCell
        //let index = cell.cellIndex
        if cellStating == .nomale {
            //正常状态 点击cell 切换页面
//            if index == self.data.count-1 {
//              //  popFolderView()
//                addCell()
//            }
            if cell.cellStyle == .cellDefault{
                addCell()
            }
            
        }else{
            //删除状态 点击cell 删除cell
            let key = Int((cell.dataModel?.key)!)
            if cell.cellStyle == .cellCustom{
                self.delelteCellAction(indexPath,id: key!)
            }else{
                Tool.log("默认不能被删除")
            }
            
        }
        
        return true
    }
   //点击添加cell的按钮
    func addCell() {
        let alertView = UIAlertController.init(title: "添加分类", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel)
        alertView.addTextField { (text) in
            text.placeholder = "分类名"
        }
        let sureAction   = UIAlertAction.init(title: "确定", style: .default) { (action) in
            
            let data = FolderModel(key: nil, title: alertView.textFields?.first?.text, bg: nil, childer: nil, time: nil)
            self.addFolder(data)
        }
        
        alertView.addAction(cancelAction)
        alertView.addAction(sureAction)
        self.present(alertView, animated: true) {
            
        }

    }
   
    //删除cell的弹框确认信息
    func delelteCellAction(_ index:IndexPath,id:Int) {
         let alertView = UIAlertController.init(title: "删除分类", message: "确定要删除该分类吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel)
        let sureAction   = UIAlertAction.init(title: "确定", style: .default) { (action) in
            if self.catalog.deleteFolderData(String(id)){
                //self.collectionView?.deleteItems(at: [index])
                self.getFolderData()
            }else{
                Tool.log("删除失败")
            }
            
        }
        
        alertView.addAction(cancelAction)
        alertView.addAction(sureAction)
        self.present(alertView, animated: true) { 
            
        }
    }
    //MARK:删除文件夹
    @IBAction func deleteCell(_ sender: AnyObject) {
        if self.cellStating == .nomale {
            self.cellStating = .delete
            (sender as! UIButton).titleLabel?.text = "列表"
        }else{
            self.cellStating = .nomale
             (sender as! UIButton).titleLabel?.text = "删除"
        }
        
        for var decell:UICollectionViewCell in (self.collectionView?.visibleCells)!{
            (decell as! CatalogCollectionViewCell).deleteStyle()
        }
    }
    
    func addFolder(_ name:FolderModel) {
        if catalog.addFolderData(name){
            getFolderData()
        }
    }
    //MARK:更新文件夹名 或 背景图片
    func updateFolder(_ name:String){
        Tool.log(name)
    }
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if case segue.identifier! = "folderList" {
            let fold = segue.destination as! FolderTableViewController
            fold.iad = String(describing: collectionView?.indexPathsForSelectedItems)
            let cell = collectionView(collectionView!, cellForItemAt: (collectionView?.indexPathsForSelectedItems?.first)!)
            fold.folderData = (cell as! CatalogCollectionViewCell).dataModel
        }
    }
    //MARK:添加长按手势
    func addGesture() {
        let gesture = UILongPressGestureRecognizer.init(target: self, action: #selector(cellLongGesture(_:)))
        gesture.minimumPressDuration = 1.0
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        self.collectionView?.addGestureRecognizer(gesture)
        
    }
    //触发长按手势 弹出 alertView视图编辑当前的cell
    func cellLongGesture(_ gesture:UILongPressGestureRecognizer) {
        if gesture.state != .ended {
            return
        }
        let point = gesture.location(in: self.collectionView)
        let indexPath = self.collectionView?.indexPathForItem(at: point)
        
        if indexPath != nil {
            let targetCell = self.collectionView?.cellForItem(at: indexPath!)
            // 获取到当前点击的cell
            setFoldercell((targetCell as! CatalogCollectionViewCell))
        }
    }
    // 编辑cell的alterView
    func setFoldercell(_ cell:CatalogCollectionViewCell) {
        let editView = EditFolderViewController.init(title: "编辑分类", message: nil, preferredStyle: .alert)
        let tit = cell.title.text
        editView.addTextField { (text) in
            text.placeholder = tit
        }
        //修过cell背景
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel)
        editView.addAction(cancelAction)
        let sureAction = UIAlertAction.init(title: "确定", style: .default) { (action) in
            self.updateFolder((editView.textFields?.first?.text)!)
        }
        
        editView.addAction(sureAction)
        self.present(editView, animated: true) {
        }
    }
    
    //MARK: 跳转限制
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (sender as! CatalogCollectionViewCell).cellIndex != self.data.count-1 && cellStating == .nomale{
            return true
        }else{
            return false
        }
    }
    
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
