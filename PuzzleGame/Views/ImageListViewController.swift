//
//  ImageListViewController.swift
//  PuzzleGame
//
//  Created by fx on 14/10/23.
//  Copyright (c) 2014年 FS. All rights reserved.
//

import UIKit

class ImageListViewController: BaseViewController {

    
    @IBOutlet weak var mainCV: UICollectionView!

    var curImageCategory:ImageCategory?=nil
    var imageListArray:NSArray? = nil
    let kImageListCell:String = "kImageListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loadData()
        self.initView()
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.mainCV.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



    
    init(imgCategory imgcategory: ImageCategory)
    {
        super.init()
        self.curImageCategory = imgcategory
    }

    required init(coder aDecoder: NSCoder) {
        super.init()
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "ImageListViewController", bundle: nibBundleOrNil)
        // Custom initialization
    }

    
    func initView()
    {
        //        header-bg-big
        mainCV.alwaysBounceVertical = true;
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "header-bg-big"), forBarMetrics: UIBarMetrics.Default)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = CommonUtil.localStringForImageCategory(self.curImageCategory?.name)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
//        UIImage(named: "bclose")
        
        //將tilte 文字設成白色粗體
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline),NSForegroundColorAttributeName: UIColor(red:1, green:1, blue:1, alpha:1)
        ];


        
        if(self.curImageCategory!.id == CUSTOMFOLDERID)
        {
            let rightView:UIView = UIView(frame: CGRectMake(0, 0, 100, 44))
            let btnAdd = UIButton(frame: CGRectMake(0, 0, 44, 44))
            let rightButton:UIButton = UIButton(frame: CGRectMake(50, 0, 44, 44))
            
            btnAdd.setImage(UIImage(named: "addImage"), forState: UIControlState.Normal)
            btnAdd.addTarget(self, action: "addImageClick:", forControlEvents: UIControlEvents.TouchUpInside)
            rightView.addSubview(btnAdd)
            
            rightButton.setBackgroundImage(UIImage(named: "bclose"), forState: UIControlState.Normal)
            rightButton.addTarget(self, action: "closeBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
            rightView.addSubview(rightButton)
            
            let rItemRight:UIBarButtonItem = UIBarButtonItem(customView: rightView)
            self.navigationItem.rightBarButtonItem = rItemRight
        }
        else
        {
            let rightButton:UIButton = UIButton(frame: CGRectMake(0, 0, 40, 40))
            rightButton.setBackgroundImage(UIImage(named: "bclose"), forState: UIControlState.Normal)
            rightButton.addTarget(self, action: "closeBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
            
            let nItemRight:UIBarButtonItem = UIBarButtonItem(customView: rightButton)
            
            self.navigationItem.rightBarButtonItem = nItemRight
        }
        

        
        
        
        

        
//        let rightView:UIView = UIView(frame: CGRectMake(0, 0, 100, 44))
//        btnGift = UIButton(frame: CGRectMake(0, 0, 44, 44))
//        sharedGift = UIButton(frame: CGRectMake(50, 0, 44, 44))
//        
//        btnGift!.setImage(UIImage(named: "gift"), forState: UIControlState.Normal)
//        btnGift!.addTarget(self, action: "btnGiftClick:", forControlEvents: UIControlEvents.TouchUpInside)
//        rightView.addSubview(btnGift!)
//        
//        sharedGift!.setImage(UIImage(named: "share"), forState: UIControlState.Normal)
//        sharedGift!.addTarget(self, action: "sharedGiftClick:", forControlEvents: UIControlEvents.TouchUpInside)
//        rightView.addSubview(sharedGift!)
//        
//        let rItemRight:UIBarButtonItem = UIBarButtonItem(customView: rightView)
//        self.navigationItem.rightBarButtonItem = rItemRight
        

        
        
        
        let nib:UINib = UINib(nibName: "ImageListCell", bundle: nil)
        self.mainCV.registerNib(nib, forCellWithReuseIdentifier: kImageListCell)
        self.mainCV.backgroundColor = UIColor.clearColor()
        

        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    func addImageClick(sender:UIButton)
    {
        
    }
    
    
    func closeBtnClick(sender:UIButton!)
    {
        self.navigationController!.popViewControllerAnimated(false)
    }
    
    func loadData()
    {
        
        let predicateImageList:NSPredicate = NSPredicate(format: "categoryid = %@", self.curImageCategory!.id)!
        
        
        println("\(curImageCategory!.id)")
        
        self.imageListArray = ImageInfo.MR_findAllWithPredicate(predicateImageList)
        
        
        
     //   ImageInfo.MR_findAllWithPredicate(searchTerm: NSPredicate!)
        
        
//        imageCategoryAry = ImageCategory.MR_findAll()
        
        
//        for imageCategoryitem in imageCategoryAry!
//        {
//            //imageCategoryitem as ImageCategory
//            
//            let item:ImageCategory = imageCategoryitem as ImageCategory
//            let imageCategoryId:String = item.id
//            
//            let itemAry:NSArray = ImageInfo.MR_findAll()
//            if(itemAry.count>0)
//            {
//                let randomNumber:Int = self.randomEx(itemAry.count)
//                let imageinfo:ImageInfo = itemAry.objectAtIndex(randomNumber) as ImageInfo
//                item.imagepath = imageinfo.path
//            }
//        }
        
    }
    
    func randomEx(number:Int)->Int
    {
        let randomNumber:Int = random() % number
        return randomNumber
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var intNumber:Int = 0
        
        if(imageListArray != nil)
        {
            intNumber = imageListArray!.count
        }
        
        
        return intNumber
        
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell:ImageListCell = collectionView.dequeueReusableCellWithReuseIdentifier(kImageListCell, forIndexPath: indexPath) as ImageListCell
        
        let imageinfoitem : ImageInfo = imageListArray!.objectAtIndex(indexPath.row) as ImageInfo
        //
        //        cell.backgroundColor = UIColor.redColor()
        cell.setimageinfo(imageinfoitem)
        //        cell.sizeToFit()
        return cell
    }
    
    //        func dequeueReusableSupplementaryViewOfKind(elementKind: String, withReuseIdentifier identifier: String, forIndexPath indexPath: NSIndexPath!) -> AnyObject
    
    //    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    //    {
    //       return 1
    //    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 15, 20, 15);
    }

    //    {
    //
    //        println("===============")
    //        return UICollectionReusableView()
    //    }
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath)
    {
        let imageInfoItem : ImageInfo = imageListArray!.objectAtIndex(indexPath.row) as ImageInfo
        
        let gameVC:GameViewController = GameViewController(imageInfo: imageInfoItem)
        
        self.navigationController?.pushViewController(gameVC, animated: true)
        
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
