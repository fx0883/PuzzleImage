//
//  ImageListViewController.swift
//  PuzzleGame
//
//  Created by fx on 14/10/23.
//  Copyright (c) 2014年 FS. All rights reserved.
//

import UIKit
import Foundation

class ImageListViewController: BaseViewController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var mainCV: UICollectionView!

    var curImageCategory:ImageCategory?=nil
    var imageListArray:NSArray? = nil
    let kImageListCell:String = "kImageListCell"
    
    var longPressEndEditing: UILongPressGestureRecognizer? = nil
    var isEditing: Bool = false
    var deleteBtn:UIBarButtonItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
//        longPressEndEditing = UILongPressGestureRecognizer(target: self, action: Selector("actionLongPressEndEditing"))
//        longPressEndEditing?.minimumPressDuration = 1
//        self.view.addGestureRecognizer(longPressEndEditing!)
        
        self.loadData()
        self.initView()
    }
    
//    func actionLongPressEndEditing() {
//        self.isEditing = false
//        self.refreshView()
//    }

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
            
            deleteBtn = UIBarButtonItem(title: "Edit", style:.Plain, target: self, action: Selector("actionEditing"))
            self.navigationItem.leftBarButtonItem = deleteBtn
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
    

    func actionEditing() {
        if (self.isEditing) {
            self.isEditing = false
            deleteBtn?.title = "Edit"
        } else {
            self.isEditing = true
            deleteBtn?.title = "Done"
        }
        
        self.refreshView()
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
    
    func collectionView(collectionView: UICollectionView,
        willDisplayCell cell: UICollectionViewCell,
        forItemAtIndexPath indexPath: NSIndexPath) {
//            if (self.isEditing)
//            {
//                cell.sway()
//            }
            cell.sway(self.isEditing)
    }
    
    func collectionView(collectionView: UICollectionView,
        didEndDisplayingCell cell: UICollectionViewCell,
        forItemAtIndexPath indexPath: NSIndexPath)
    {
        cell.sway(false)

    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell:ImageListCell = collectionView.dequeueReusableCellWithReuseIdentifier(kImageListCell, forIndexPath: indexPath) as ImageListCell
        
        let imageinfoitem : ImageInfo = imageListArray!.objectAtIndex(indexPath.row) as ImageInfo
        //
        //        cell.backgroundColor = UIColor.redColor()
        cell.setimageinfo(imageinfoitem)
        
        cell.removeAllGestures()
        
        
        ///
        cell.ivDelete.userInteractionEnabled = true;
        cell.ivDelete.tag = indexPath.row
        let gest = UITapGestureRecognizer(target: self, action: Selector("actionDelete:"))
        cell.ivDelete.addGestureRecognizer(gest)
        
        let prevBtn:UIButton? = cell.ivDelete.subviews.first as? UIButton
        if let prevBtnCopy = prevBtn {
            prevBtnCopy.removeFromSuperview()
        }
        
        let btn = UIButton()
        btn.frame = cell.ivDelete.bounds
        btn.tag = indexPath.row
        btn.addTarget(self, action: Selector("actionDelete:"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.ivDelete .addSubview(btn)
        
        ///
//        cell.layer.removeAllAnimations()
        if (self.isEditing) {
            cell.ivDelete.hidden = false;
            // add Animation
        } else {
            cell.ivDelete.hidden = true;
        }
        //        cell.sizeToFit()
        
//        cell.sway(true)
        return cell
    }
    
    //        func dequeueReusableSupplementaryViewOfKind(elementKind: String, withReuseIdentifier identifier: String, forIndexPath indexPath: NSIndexPath!) -> AnyObject
    
    //    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    //    {
    //       return 1
    //    }
    
    func actionDelete(sender: UIView) {
        let index: NSInteger = sender.tag
        let imageinfoitem : ImageInfo = imageListArray!.objectAtIndex(index) as ImageInfo
        imageinfoitem.MR_deleteEntity()
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
        self.refreshView()
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 15, 20, 15);
    }

    //    {
    //
    //        println("===============")
    //        return UICollectionReusableView()
    //    }
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        
        if (self.isEditing) {
            return;
        }
        
        let imageInfoItem : ImageInfo = imageListArray!.objectAtIndex(indexPath.row) as ImageInfo
        
        let gameVC:GameViewController = GameViewController(imageInfo: imageInfoItem)
        
        self.navigationController?.pushViewController(gameVC, animated: true)
        
    }
    
    
    
    
    func addImageClick(sender:UIButton)
    {
        //            [[[UIActionSheet alloc] initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"内置图片",@"照像机",@"图库",@"相册", nil] showInView:self.view];
        
        //        let actionsheet:UIActionSheet = UIActionSheet(title: "选择图片来源", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil,otherButtonTitles:@"内置图片",@"照像机",@"图库",@"相册", nil);
        
        var selectedPathSourceStr:NSString = CommonUtil.localStringForImageCategory("选择图片来源")
        var cameraStr:NSString = CommonUtil.localStringForImageCategory("照像机")
        var photolibraryStr:NSString = CommonUtil.localStringForImageCategory("图库")
        var photoAlbumStr:NSString = CommonUtil.localStringForImageCategory("相册")
        var cancelStr:NSString = CommonUtil.localStringForImageCategory("取消")
        
        let actionsheet:UIActionSheet = UIActionSheet(title: selectedPathSourceStr, delegate: self, cancelButtonTitle: cancelStr, destructiveButtonTitle: nil, otherButtonTitles: cameraStr,photolibraryStr,photoAlbumStr)
        //        otherButtonTitles firstButtonTitle: String, _ moreButtonTitles: String...)
        actionsheet.showInView(self.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        
        //        UIImagePickerController * upc;
        
        
        var upc:UIImagePickerController?
        
        switch (buttonIndex) {
            
        case 1://照像机
            
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
            {
                upc = UIImagePickerController()
                upc!.sourceType = UIImagePickerControllerSourceType.Camera
                upc!.delegate = self;
                self.presentViewController(upc!, animated: true, completion: nil)
                break;
            }
            break;
            
        case 2://图库
            
            //            upc = [[UIImagePickerController alloc] init];
            //            upc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            upc.delegate=self;
            //            [self presentModalViewController:upc animated:YES];
            
               upc = UIImagePickerController()
               upc!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
               upc!.delegate = self;
               self.presentViewController(upc!, animated: true, completion: nil)
            
            
            break;
        case 3://相册
            
            
                upc = UIImagePickerController()
                upc!.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
                upc!.delegate = self;
                self.presentViewController(upc!, animated: true, completion: nil)

            //            upc = [[UIImagePickerController alloc] init];
            //            upc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            //            upc.delegate=self;
            //            [self presentModalViewController:upc animated:YES];
            break;
            
        default:
            break;
            
        }
    }
    

    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: NSDictionary!)
    {
        //    [self dismissModalViewControllerAnimated:YES];
        self.dismissViewControllerAnimated(true, completion: nil)
        
        var image:UIImage!
        
        if picker.allowsEditing {
            image = info.objectForKey(UIImagePickerControllerEditedImage) as UIImage
        }else{
            image = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        }
        
        image! = image!.fixOrientation();
//        let image:UIImage = info as UIImage;
        var width:UInt = CGImageGetWidth(image.CGImage)
        var height:UInt = CGImageGetHeight(image.CGImage)

        let isWidthlength = width>height
        
        var    minValue:UInt = min(width, height)
        //
        var newImage:UIImage? = nil;
            if (minValue>320) {
        var imageWidth:CGFloat=CGFloat(320);
        
        var rect:CGRect?
        
        if(isWidthlength)
        {
            rect=CGRectMake(CGFloat((width-height)/2), 0, CGFloat(minValue), CGFloat(minValue))
        }
        else
        {
            rect=CGRectMake(0, CGFloat((height-width)/2), CGFloat(minValue), CGFloat(minValue))
        }
            
        let scrCopy:CGImageRef = CGImageCreateWithImageInRect(image.CGImage,rect!)

        newImage = UIImage(CGImage: scrCopy)!

        UIGraphicsBeginImageContext(CGSizeMake(imageWidth, imageWidth));
        newImage!.drawInRect(CGRectMake(0, 0, imageWidth, imageWidth))
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
            }
        else
            {
              newImage = UIImage(CGImage: CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, CGFloat(minValue), CGFloat(minValue))))!
        }
        
//        NSData *data;
        var data:NSData
        
        
        
          data = UIImageJPEGRepresentation(newImage, 0.3);
//
//        UIImagePNGRepresentation转换PNG格式的图片为二进制，如果图片的格式为JPEG则返回nil；
//        [fileManager createFileAtPath:[filePath stringByAppendingString:@"/image.png"] contents:data attributes:nil];    将图片保存为PNG格式
//        
//        [fileManager createFileAtPath:[filePath stringByAppendingString:@"/image.jpg"] contents:data attributes:nil];   将图片保存为JPEG格式
        // NSUUID().UUIDString;
        
        
        
        var md5Data:NSString = data.md5()
        
        //MR_findByAttribute:(NSString *)attribute withValue:(id)searchValue;
        var array:NSArray = ImageInfo.MR_findByAttribute("id", withValue:md5Data)
        if(array.count > 0)
        {
            return;
        }
        
        
        let itemImageInfo:ImageInfo = ImageInfo.MR_createEntity()
        

        
        
        itemImageInfo.id = md5Data
        itemImageInfo.categoryid = CUSTOMFOLDERID
        itemImageInfo.fastesttime=nil
        
        //这里用md5码
        var strPath:NSString = NSString(format: "%@.jpg", itemImageInfo.id)
        
        itemImageInfo.path = strPath
        itemImageInfo.isfinished = NSNumber(bool: false)
        
        
        strPath = strPath.lastPathComponent
        //                println("\(itemImageInfo.path)")
        
        itemImageInfo.path = CUSTOMFOLDERID+"/"+strPath
        
    //    println("\(itemImageInfo.path)")
        
        //        [fileManager createFileAtPath:[filePath stringByAppendingString:@"/image.jpg"] contents:data attributes:nil];
        var imagePath:NSString = NSString(format: "%@/%@",BMSandbox.sharedInstance().docPath,itemImageInfo.path)
        
        var str:String = String(imagePath)
        
        println(imagePath)
        
        NSFileManager.defaultManager().createFileAtPath(imagePath, contents: data, attributes: nil);
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
        self.refreshView()
        
    }
    
    
  func refreshView()
  {
    self.loadData()
    self.mainCV.reloadData()
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
