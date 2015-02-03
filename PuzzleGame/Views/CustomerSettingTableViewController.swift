//
//  CustomerSettingTableViewController.swift
//  PuzzleGame
//
//  Created by 冯璇 on 15/1/29.
//  Copyright (c) 2015年 FS. All rights reserved.
//

import UIKit

class CustomerSettingTableViewController: UITableViewController,UIAlertViewDelegate,MFMailComposeViewControllerDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "SettingCell")
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 2
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("SettingCell", forIndexPath: indexPath) as? UITableViewCell

        if(indexPath.row==0)
        {
            cell!.textLabel?.text = CommonUtil.localStringForImageCategory("移除广告")
        }
        else if(indexPath.row==1)
        {
            cell!.textLabel?.text = CommonUtil.localStringForImageCategory("恢复购买")
        }
        cell?.backgroundColor = UIColor.clearColor()
        cell?.textLabel?.textColor = UIColor.whiteColor()

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if(indexPath.row==0)
        {
            let hasRemovedAds  =  HMIAPHelper.sharedInstance().hasRemovedAds()
            if(hasRemovedAds)
            {
                let alert:UIAlertView = UIAlertView(title: CommonUtil.localStringForImageCategory("Already Removed"), message: CommonUtil.localStringForImageCategory("Ads has already been removed,if there are still any issues,please contact us."), delegate: self, cancelButtonTitle: CommonUtil.localStringForImageCategory("Contact us"), otherButtonTitles: CommonUtil.localStringForImageCategory("Okay"))
                
                alert.show()
            }
            else
            {
                HMIAPHelper.sharedInstance().removeAds()
            }
            
        }
        else if(indexPath.row==1)
        {
            if(HMIAPHelper.sharedInstance().hasRemovedAds())
            {
                HMIAPHelper.sharedInstance().restoreCompletedTransactions()
                let alert:UIAlertView = UIAlertView(title: CommonUtil.localStringForImageCategory("Already Removed"), message: CommonUtil.localStringForImageCategory("Ads has already been removed,if there are still any issues,please contact us."), delegate: self, cancelButtonTitle: CommonUtil.localStringForImageCategory("Contact us"), otherButtonTitles: CommonUtil.localStringForImageCategory("Okay"))
                
                alert.show()
            }
        }

    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(buttonIndex==0)
        {
            self.sendEmail()
        }
    }
    
    
    func sendEmail(){
        
        if(MFMailComposeViewController.canSendMail())
        {
            //    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
            
            let mailComposeViewController:MFMailComposeViewController = MFMailComposeViewController()
                mailComposeViewController.setSubject(CommonUtil.localStringForImageCategory("Puzzle - Feedback"))
                mailComposeViewController.setToRecipients(["jackfeng8123@gmail.com"])
                mailComposeViewController.setMessageBody("Why is me?", isHTML: false)
            mailComposeViewController.navigationBar.tintColor=UIColor(red:(95.0 / 255.0),
                green:(64.0 / 255.0),
                blue:(222.0 / 255.0),
                alpha:1.0)
            mailComposeViewController.mailComposeDelegate=self
            self.presentViewController(mailComposeViewController, animated: true, completion: { () -> Void in
                
            })
            //    [mailComposeViewController setSubject:@"Math Match - Feedback"];
            //    [mailComposeViewController setToRecipients:@[@"dymx102@gmail.com"]];
            //    [mailComposeViewController setMessageBody:@"" isHTML:NO];
            //
            //    mailComposeViewController.navigationBar.tintColor = [UIColor mmx_purpleColor];
            //    mailComposeViewController.mailComposeDelegate = self;
            //
            //    [self presentViewController:mailComposeViewController animated:YES completion:nil];
        }
        else
        {
            let message:NSString = CommonUtil.localStringForImageCategory("Can't send because no email account is configured on this device.")
            let decisionView:KMODecisionView =  KMODecisionView(message: message, delegate: nil, cancelButtonTitle: CommonUtil.localStringForImageCategory("Okay"), otherButtonTitles: nil)
            decisionView.showInViewController(self, andDimBackgroundWithPercent: 0.50)
            
            
            //("Can't send because no email account is configured on this device.")
            //
            //    KMODecisionView *decisionView = [[KMODecisionView alloc] initWithMessage:message
            //    delegate:nil
            //    cancelButtonTitle:NSLocalizedString(@"Okay", nil)
            //    otherButtonTitles:nil];
            //    [decisionView showInViewController:self andDimBackgroundWithPercent:0.50];
        }
        
    }
    
    
    
    
//    -(void)sendEmail {
//    if ([MFMailComposeViewController canSendMail])
//    {
//    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
//    [mailComposeViewController setSubject:@"Math Match - Feedback"];
//    [mailComposeViewController setToRecipients:@[@"dymx102@gmail.com"]];
//    [mailComposeViewController setMessageBody:@"" isHTML:NO];
//    
//    mailComposeViewController.navigationBar.tintColor = [UIColor mmx_purpleColor];
//    mailComposeViewController.mailComposeDelegate = self;
//    
//    [self presentViewController:mailComposeViewController animated:YES completion:nil];
//    }
//    else
//    {
//    NSString *message = NSLocalizedString(@"Can't send because no email account is configured on this device.", nil);
//    
//    KMODecisionView *decisionView = [[KMODecisionView alloc] initWithMessage:message
//    delegate:nil
//    cancelButtonTitle:NSLocalizedString(@"Okay", nil)
//    otherButtonTitles:nil];
//    [decisionView showInViewController:self andDimBackgroundWithPercent:0.50];
//    }
//    }
    
    
    
//    if (indexPath.row == 2) {
//    // remove all ads
//    BOOL hasRemovedAds = [SharedIAP hasRemovedAds];
//    if (hasRemovedAds) {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Already Removed" message:@"Ads has already been removed, if there are still any issues, please contact us." delegate:self cancelButtonTitle:@"Contact us" otherButtonTitles:@"Okay", nil];
//    [alert show];
//    } else {
//    [SharedIAP removeAds];
//    }
//    
//    } else if (indexPath.row == 3) {
//    // restore purchase
//    if (![SharedIAP hasRemovedAds]) {
//    [SharedIAP restoreCompletedTransactions];
//    }
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
}
