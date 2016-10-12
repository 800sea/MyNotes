//
//  CatalogViewController.swift
//  MyNotes
//
//  Created by sea on 16/10/11.
//  Copyright © 2016年 sea. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CatalogViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate{

    //cell 图标选择的容器
    @IBOutlet weak var iconView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    //数据原
    var data = Array<FolderModel>(){
        didSet{
            //添加 默认的按钮的那个数据
            data.append(FolderModel(key: "", title: "添加", bg: "bg", childer: nil, time: nil))
            self.collectionView?.reloadData()
        }
    }
    // cell的状态有3种 正常 删除 编辑
    enum cellState:String{
        case nomale = "nomale"  //正常状态
        case delete = "delete"  //删除状态
        case edit   = "edit"  //编辑状态
    }
    //cell的当前状态 默认是正常状态
    var cellStating:cellState = .nomale{
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: cellStyleNotification.name), object: self, userInfo: [cellStyleNotification.infoKey:cellStating])
            //退出编辑状态时
            if cellStating == .nomale {
                
            }
        }
    }
    let catalog = Catalog()
    var iconListView: IconList!;
    //通知的名字
    struct cellStyleNotification {
       static let name = "styleChange"
       static let infoKey = "cellStyle"
    }
    //记录当前编辑的cell
    var targetEditCell:CatalogCollectionViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        getFolderData()
        self.view.backgroundColor = Tool.getBgColor(.A)
        self.automaticallyAdjustsScrollViewInsets = false
        addGesture()
    }

    //获取当前用户的文件夹列表
    func getFolderData(){
        self.data = catalog.getFolderData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NotificationCenter.default.removeObserver(self)
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UICollectionViewDataSource
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CatalogCollectionViewCell
        let cellData = self.data[indexPath.row]
        cell.dataModel = cellData
        cell.cellIndex = indexPath.row
        cell.addListen()
        
        if indexPath.row == data.count-1 {
            cell.setCellStyle(.cellDefault)
        }else{
            cell.setCellStyle(.cellCustom)
        }
        
        
        return cell
    }
    //MARK:切换到编辑模式
    @IBAction func editCellfuc(_ sender: UIButton) {
        if cellStating == .nomale{
            cellStating = .edit
            (sender as UIButton).setTitle("编辑", for: .normal)
        }else{
            
            cellStating = .nomale
            (sender as UIButton).setTitle("列表", for: .normal)
            if iconViewheight.constant == 80.0 {
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                    self.iconViewheight.constant = 15.0
                    //删除图标选择栏
                    self.iconListView.removeFromSuperview()
                    self.view.layoutIfNeeded()
                    }, completion: { (b) in
                        
                })
            }
           
        }
    }
     //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if case segue.identifier! = "folderList" {
            let fold = segue.destination as! FolderTableViewController
            fold.iad = String(describing: collectionView?.indexPathsForSelectedItems)
            let cell = collectionView(collectionView!, cellForItemAt: (collectionView?.indexPathsForSelectedItems?.first)!)
            fold.folderData = (cell as! CatalogCollectionViewCell).dataModel
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

    
    //MARK:cell被点击
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CatalogCollectionViewCell
        if cellStating == .nomale {
            if cell.cellStyle == .cellDefault{
                addCell()
            }
            
        }else{
            //编辑状态点击cell
            let key = Int((cell.dataModel?.key)!)
            editCellView(cell: cell)
            //            if cell.cellStyle == .cellCustom{
            //                self.delelteCellAction(indexPath,id: key!)
            //            }else{
            //                Tool.log("默认不能被删除")
            //            }
            
        }
        
        return true
    }
    
    
    @IBOutlet weak var iconViewheight: NSLayoutConstraint!
    //编辑点击的cell
    func editCellView(cell:CatalogCollectionViewCell){
        //进入编辑状态 标题可编辑
        targetEditCell = cell
        targetEditCell!.cellIsEdit = true
        targetEditCell!.titleText.delegate = self
        iconView.translatesAutoresizingMaskIntoConstraints = false
        if iconViewheight.constant == 15.0 {
            self.iconListView = IconList(inView: self.iconView)
            self.iconView.addSubview(self.iconListView)
//            UIView.animate(withDuration: 1.0, delay: 0.01, usingSpringWithDamping: 0.5, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: {
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                self.iconViewheight.constant = 80.0
                self.view.layoutIfNeeded()
                
                self.iconListView.showIconAnimate()
               
                }, completion: { (b) in
                    
            })
            //根据选择修改图片
            self.iconListView.selectItem = {index in
                self.targetEditCell!.image.image = UIImage.init(named: "icon_\(index).png")
                //保存 bg图片名
                self.targetEditCell!.dataModel?.bg = "icon_\(index).png"
            }
        }
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        targetEditCell?.titleText.resignFirstResponder()
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
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
    //MARK:添加长按手势
    func addGesture() {
        let gesture = UILongPressGestureRecognizer.init(target: self, action: #selector(cellLongGesture(_:)))
        gesture.minimumPressDuration = 1.0
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        self.collectionView?.addGestureRecognizer(gesture)
    }
    
    //触发长按手势 弹出 alertView视图确定是否删除cell
    func cellLongGesture(_ gesture:UILongPressGestureRecognizer) {
        if gesture.state != .ended {
            return
        }
        let point = gesture.location(in: self.collectionView)
        let indexPath = self.collectionView?.indexPathForItem(at: point)
        
        if indexPath != nil {
            let targetCell = self.collectionView?.cellForItem(at: indexPath!)
            // 获取到当前点击的cell
            //setFoldercell((targetCell as! CatalogCollectionViewCell))
            deleteFolderCell(key: (targetCell as! CatalogCollectionViewCell).dataModel?.key)
        }
    }
    
    func deleteFolderCell(key:String!){
        let editView = EditFolderViewController.init(title: "删除分类", message: "确定要删除选中分类", preferredStyle: .alert)
        let sureAction = UIAlertAction.init(title: "确定", style: .destructive) { (alert) in
            if self.catalog.deleteFolderData(String(key)){
                //self.collectionView?.deleteItems(at: [index])
                self.getFolderData()
            }else{
                Tool.log("删除失败")
            }
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel)

        editView.addAction(sureAction)
        editView.addAction(cancelAction)
        
        self.present(editView, animated: true) {
        }
    }
    
    //MARK: 文件夹增加
    func addFolder(_ name:FolderModel) {
        if catalog.addFolderData(name){
            getFolderData()
        }
    }
    //MARK:更新文件夹名 或 背景图片
    func updateFolder(_ model:FolderModel){
        if catalog.updateFolderData(model){
            Tool.log("更新成功")
        }
        //Tool.log(name)
    }


}
