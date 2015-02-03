//
//  ImageCategoryCollectionViewCell.swift
//  PuzzleGame
//
//  Created by fx on 14-10-11.
//  Copyright (c) 2014年 FS. All rights reserved.
//

import UIKit

class ImageCategoryCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    @IBOutlet weak var stack: UIImageView!
    
    @IBOutlet weak var footLabel: UILabel!
    @IBOutlet weak var imvMain: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    var _imagecategory:ImageCategory?
    
    func setimagecategory(imagecategory:ImageCategory)
    {
        _imagecategory = imagecategory
        imvMain.applyEffectRoundRectSilverBorder(UIColor.whiteColor())
        titleLabel.text = "Hot"
        footLabel.text = CommonUtil.localStringForImageCategory(imagecategory.name)
        var path:String?=nil
        if(imagecategory.imagepath == nil)
        {
            if(imagecategory.id == CUSTOMSETTINGID)
            {
                titleLabel.text = "Settings"
                stack.image = nil
                imvMain.image = UIImage(named: "settings")
            }
            else
            {
                path = "defultImageCategory.jpg"
                imvMain.image = UIImage(named: path!)
            }

        }
        else
        {
            if(imagecategory.id == CUSTOMFOLDERID)
            {
                titleLabel.text = "Mine"
                path = String(imagecategory.imagepath)
                imvMain.image = UIImage(named: path!)
            }
            else
            {
                path = (BMContext.sharedInstance().getContextDicForKey(COREBUNDLENAME) as String) + "/" + imagecategory.imagepath
                
                imvMain.image = UIImage(contentsOfFile: path!)
            }
            
            
            
        }

        
        

    


    }
}
