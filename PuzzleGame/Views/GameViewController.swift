//
//  GameViewController.swift
//  PuzzleGame
//
//  Created by fx on 14/10/26.
//  Copyright (c) 2014年 FS. All rights reserved.
//

import UIKit

class GameViewController: BaseViewController,GameViewDelegate {

    @IBOutlet weak var gameview: GameView!
    @IBOutlet weak var disorganizeButton: UIButton!
//    @IBOutlet weak var originalPicButton: UIButton!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    
    @IBOutlet weak var lblDifficulty: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    
    @IBOutlet weak var difficultySlider: UISlider!

    
//    let strTitle:NSString = "过关了"
//    let strContent:NSString? = nil
//    let strDescription:NSString = "愉快地游戏"
//    let imageContent:UIImage? = nil
//    let strUrl:NSString = "https://itunes.apple.com/us/app/puzzle-crazy/id921615471?l=zh&ls=1&mt=8"

    var popupView:ShareGameView? = nil
    var shareImage:UIImage? = nil

    
    @IBAction func difficultyChanged(sender: AnyObject) {
        
        let sider:UISlider = sender as UISlider
        difficultyLabel.text = NSString(format: "%d", Int(sider.value))
    }
    var curImageInfo:ImageInfo? = nil
    var bIsFinishedGame:Bool = false
    var breakBtnStatus:Int = 1
    var timer:NSTimer? = nil
    var gameBeginTime:NSTimeInterval?=nil
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
        
        
        // Do any additional setup after loading the view.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "GameViewController", bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    func finishedGame()
    {
        self.curImageInfo?.isfinished = NSNumber(bool: true)
        self.bIsFinishedGame = true;
        self.startAnimateBannerView()
        
        if(self.gameBeginTime != nil)
        {
            //完成游戏时间
            var finishedGame:Int =  Int(NSDate.timeIntervalSinceReferenceDate() - self.gameBeginTime!)
            
            var strMsg:NSString = NSString(format: NSLocalizedString("stage_clear", comment: ""), finishedGame)
            if(self.curImageInfo?.fastesttime == nil)
            {
                self.curImageInfo!.fastesttime = NSNumber(integer:finishedGame)
                self.navigationItem.title = self.getTitle()
            }
            
            else if(self.curImageInfo?.fastesttime.integerValue > finishedGame)
            {
                self.curImageInfo!.fastesttime = NSNumber(integer:finishedGame)
                self.navigationItem.title = self.getTitle()
            }
            
            
            //[[[UIAlertView alloc] initWithTitle:@"恭喜您" message:@"拼图成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil] show];
            
          //  UIAlertView(title: "恭喜您", message: strMsg, delegate: self, cancelButtonTitle: "关闭").show()
            
            
            self.finishGameView(strMsg)
            
            
        }
    }
    
    
    func finishGameView(msg:NSString)
    {
        self.popupView!.msgContentLabel.text = msg;
        self.popupView!.sharedImage = self.shareImage;
        
        
        
        var color:UIColor? = UIColor.grayColor()
        let style:ASDepthModalOptions =  ASDepthModalOptions.AnimationGrow
        var options:ASDepthModalOptions? = nil
        
        var colorConfigurationIndex:NSInteger
        var styleConfigurationIndex:NSInteger
//        NSInteger colorConfigurationIndex;
//        NSInteger styleConfigurationIndex;
//        
//        colorConfigurationIndex = [self.colorTableView indexPathForSelectedRow].row;
        colorConfigurationIndex = 1
//        if(colorConfigurationIndex == 1)
//        {
//            UIImage *image;
//            
//            // This image comes from http://www.numero111.com/wp-content/uploads/2010/11/ist2_7360872-elegant-abstract-wallpaper-pattern-background-tiles-seamlessly.jpg
//            image = [UIImage imageNamed:@"pattern1.jpg"];
//            color = [UIColor colorWithPatternImage:image];
//        }
//        
      options = style | ASDepthModalOptions.Blur | ASDepthModalOptions.TapOutsideInactive
//        options = style | (self.blurSwitch.on?ASDepthModalOptionBlur:ASDepthModalOptionBlurNone) | (self.tapOutsideSwitch.on?ASDepthModalOptionTapOutsideToClose:ASDepthModalOptionTapOutsideInactive);
//        
//        [ASDepthModalViewController presentView:self.popupView
//            backgroundColor:color
//            options:options
//            completionHandler:^{
//            NSLog(@"Modal view closed.");
//            }];
        ASDepthModalViewController.presentView(self.popupView, backgroundColor: color, options: options!) { () -> Void in
            println("Modal view closed.")
        }
        

    }
    
    init(imageInfo imageinfo: ImageInfo)
    {
        super.init()
        self.curImageInfo = imageinfo
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func initView()
    {
//            [gameView setGameImage:[[UIImage imageNamed:[Data nextInnerImg]] CGImage]];
        self.edgesForExtendedLayout = UIRectEdge.None
        var path:String?=nil
        if(self.curImageInfo?.path != nil)
        {
 
            path = (BMContext.sharedInstance().getContextDicForKey(COREBUNDLENAME) as String) + "/" + self.curImageInfo!.path
            
            self.shareImage = UIImage(contentsOfFile: path!)!
            
            gameview.setGameImage2(self.shareImage!.CGImage)
            
            gameview.layer.borderColor = UIColor.whiteColor().CGColor
            gameview.layer.borderWidth = 1.0
        }
        
        let str:NSString = NSLocalizedString("difficulty", comment: "")
        lblDifficulty.text = str;
        
        let str1:NSString = NSLocalizedString("start_play", comment: "")
        btnStart.setTitle(str1, forState: .Normal)
        
        
        self.navigationItem.hidesBackButton = true

        UIImage(named: "bclose")
        
        let rightButton:UIButton = UIButton(frame: CGRectMake(0, 0, 40, 40))
        rightButton.setBackgroundImage(UIImage(named: "bclose"), forState: UIControlState.Normal)
        rightButton.addTarget(self, action: "closeBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let nItemRight:UIBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        //將tilte 文字設成白色粗體
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline),NSForegroundColorAttributeName: UIColor(red:1, green:1, blue:1, alpha:1)
        ];
        
        
        self.navigationItem.rightBarButtonItem = nItemRight

        
        gameview.delegate = self
        
        self.navigationItem.title = self.getTitle()
        
//        [LotteryInvestigationView *lotteryInvestigationView=[[[NSBundle mainBundle] loadNibNamed:@"LotteryInvestigationView" owner:self options:nil] lastObject];
        
        self.popupView =  NSBundle.mainBundle().loadNibNamed("ShareGameView", owner: self, options: nil).last as? ShareGameView
        
//        popupView = ShareGameView(
        self.popupView!.frame = CGRectMake(0, 0, 280, 180)
        
//        [LotteryInvestigationView *lotteryInvestigationView=[[[NSBundle mainBundle] loadNibNamed:@"LotteryInvestigationView" owner:self options:nil] lastObject];
//        [lotteryInvestigationView setFrame:frame];
//        [self addSubview:lotteryInvestigationView];
        

        self.popupView!.layer.cornerRadius = 12;
        self.popupView!.layer.shadowOpacity = 0.7;
        self.popupView!.layer.shadowOffset = CGSizeMake(6, 6);
        self.popupView!.layer.shouldRasterize = true;
        self.popupView!.layer.rasterizationScale = UIScreen.mainScreen().scale
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func originalPicButton() {
        
        let originalpicviewcontroller:OriginalPicViewController = OriginalPicViewController(imageInfo: self.curImageInfo!)
        
//        
//        [self presentViewController:storeProductViewContorller animated:YES completion:^{
//            
//            }
        
        self.presentViewController(originalpicviewcontroller, animated: true) { () -> Void in
            
        }

        
        
    }
    
    func getTitle() ->NSString
    {
        var title:NSString = ""
        if(self.curImageInfo!.fastesttime==nil)
        {
           title = NSLocalizedString("stage_not_clear", comment: "")
        }
        else
        {
           title = NSString(format: NSLocalizedString("top_record_sec", comment: ""),self.curImageInfo!.fastesttime.integerValue)
        }
        
        
        
        return title
    }
    
    
    
    
    func closeBtnClick(sender:UIButton!)
    {
        if(self.bIsFinishedGame)
        {
            self.startInterstitialView()
        }
        self.navigationController!.popViewControllerAnimated(true)

        
    }
    
    @IBAction func disorganizeButton(sender: UIButton) {
        switch self.breakBtnStatus
        {
        case 1:
            
            
            breakBtnStatus=2;
//            [breakBtn setTitle:@"停止" forState:UIControlStateNormal];
            
            disorganizeButton.setTitle(NSLocalizedString("original_picture", comment: ""), forState: UIControlState.Normal)
            let  timeinterval = NSTimeInterval(self.difficultySlider.value/10)
            self.difficultySlider.enabled = false
            
            self.startBreakByTimer(timeinterval)
//            showSourceBtn.hidden=YES;
//            changeImageBtn.hidden=YES;
//            gameview.startBreak();
            break;
        case 2:
//            breakBtnStatus=1;
//            disorganizeButton.setTitle("原图", forState: UIControlState.Normal)
            
//            showSourceBtn.hidden=NO;
//            changeImageBtn.hidden=NO;
            
//            gameview.stopBreak();
            self.originalPicButton()
            break;
        default:
            break;
        }

        
    }
    
    func startBreakByTimer(timeinterval:NSTimeInterval)
    {
        gameview.startBreak();
//        timer=NSTimer(timeInterval: 2, target: self, selector:"timeTick", userInfo: nil, repeats: true)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(timeinterval, target: self, selector: "timeTick", userInfo: nil, repeats:false);
        
        
//            init(fireDate date: NSDate, interval ti: NSTimeInterval, target t: AnyObject, selector s: Selector, userInfo ui: AnyObject?, repeats rep: Bool)
        
//        timer = NSTimer(fireDate: NSDate.date, interval: <#NSTimeInterval#>, target: <#AnyObject#>, selector: <#Selector#>, userInfo: <#AnyObject?#>, repeats: <#Bool#>)
//        
      //  timer!.fire();
        
        
    }
    
    func timeTick()
    {
        gameview.stopBreak()
        
        //开始game记时间
        gameBeginTime = NSDate.timeIntervalSinceReferenceDate()
        
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
