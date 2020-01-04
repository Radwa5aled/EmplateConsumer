//
//  PostCell.swift
//  EmplateConsumer
//
//  Created by Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//

import UIKit
import Kingfisher

class PostCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var viewReservable: UIView!
    @IBOutlet weak var consPostImageHeight: NSLayoutConstraint!
    @IBOutlet weak var lblBottomName: UILabel!
    @IBOutlet weak var stkPrice: UIStackView!
    @IBOutlet weak var lblOriginalPrice: UILabel!
    @IBOutlet weak var lblOfferedPrice: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblExpireDate: UILabel!
    @IBOutlet weak var btnReserveItem: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(model:PostsModel) {
        
        //set post name
        lblName.text = model.name
        lblBottomName.text = model.name
        
        //hide viewReservable
        btnReserveItem.isHidden = !(model.collectible ?? false)
        viewReservable.isHidden = !(model.collectible ?? false)
        
        //Caculate height according to api width|height factor ratio
        consPostImageHeight.constant = Utilities.shared.getWidth_HeightFactor(viewWidth: self.frame.width, width: CGFloat(model.thumbnail?.width ?? 250), height: CGFloat(model.thumbnail?.height ?? 250))
        
        //image handle
        setImageFromCachedData(urls:(model.thumbnail?.urls)!)
       
        //date handle
        lblExpireDate.text = Utilities.shared.getExpirationDateFromCurent(stopDateStr: (model.postperiods?.first?.stop) ?? "", startDateStr: (model.postperiods?.first?.start) ?? "")
        
        //price handle
        if let content = model.postfields?.first?.contentObject {
            setPriceData(content: content)
        }else {
            stkPrice.isHidden = true
        }
 
    }
    
     //#MARK:- handle price cases and set it's values if not nil, Otherwise hide price labels
    func setPriceData(content:ContentModel) {
        
        stkPrice.isHidden = false
        if let pAfter = content.price, pAfter != "" {
            stkPrice.isHidden = false
            lblOfferedPrice.text = "Pris: " + pAfter
            
            if let pBefore = content.priceBefore, pBefore != ""{
                lblOriginalPrice.isHidden = false
                lblOriginalPrice.attributedText = Utilities.shared.getAttributedStr(str: pBefore)
                
                if let discount = content.discount, discount != "" {
                    lblDiscount.isHidden = false
                    lblDiscount.text = "Spar: " + discount
                }else {
                    lblDiscount.isHidden = true
                }
            }else {
                lblOriginalPrice.isHidden = true
                lblDiscount.isHidden = true
            }
        }else {
            stkPrice.isHidden = true
        }
    }
    
   //#MARK:- Check if images in cache then set it from cache, Otherwise download thumbnail image without caching and view it until mobile image downloaded
    func setImageFromCachedData(urls:ThumbnailUrls) {
        
        self.imgPost.image = UIImage()
        self.imgPost.kf.indicatorType = .activity
        
        if let url = URL(string: (urls.mobile ?? "" )) {
            let cache = ImageCache.default
            let cached = cache.isCached(forKey: url.absoluteString)
            if cached {
                self.imgPost.kf.setImage(with: url, options: [.transition(.fade(0.4)), .onlyFromCache])
            }else {
                
                Utilities.shared.downloadImageFromUrl(tmbUrlStr:  urls.thumbnail ?? "", success: { (img) -> (Void) in
                    
                    self.imgPost.kf.setImage(with: url, placeholder: img, options: [.transition(.fade(0.4))])
                    
                }) { (err) -> (Void) in
                    
                    self.imgPost.kf.setImage(with: url, options: [.transition(.fade(0.4))])
                    
                }
            }
        }
    }
    
}
