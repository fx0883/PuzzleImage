//
//  ImageListCell.swift
//  PuzzleGame
//
//  Created by fx on 14/10/23.
//  Copyright (c) 2014年 FS. All rights reserved.
//

import UIKit

class ImageListCell: UICollectionViewCell {

    @IBOutlet weak var imvComplete: UIImageView!
    var curImageInfo:ImageInfo? = nil
    @IBOutlet weak var imvMain: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setimageinfo(imageinfo:ImageInfo)
    {
        curImageInfo = imageinfo
        if(imageinfo.path != nil)
        {
            var path:String?=nil
            path = (BMContext.sharedInstance().getContextDicForKey(COREBUNDLENAME) as String) + "/" + imageinfo.path
            imvMain.image = UIImage(contentsOfFile: path!)
        }
              imvMain.applyEffectRoundRectSilverBorder(UIColor.whiteColor())
  
//        Bool flagIsHidden = curImageInfo!.isfinished.boolValue
        
        imvComplete.hidden = !curImageInfo!.isfinished.boolValue
    }
}
