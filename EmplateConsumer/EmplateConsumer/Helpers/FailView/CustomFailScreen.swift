

import UIKit

class CustomFailScreen: UIView {
    
    @IBOutlet weak var reloadBtn: UIButton!
    @IBOutlet weak var statusImgView: UIImageView!
    @IBOutlet weak var messageLAbel: UILabel!
    var message:String? = "please try again"
    var handler:(()->())?
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func showComingSoon() {
        reloadBtn.isHidden = true
        statusImgView.image = #imageLiteral(resourceName: "nafathService.jpeg")
        messageLAbel.text = "Coming soon"
    }
    
    func setViewData(handler:@escaping ()->()) {
        self.messageLAbel.text = message
        self.handler = handler
    }
    
    
    @IBAction func reloadAction(_ sender: UIButton) {
        handler?()
    }
    
    func getFromNib<T>(view:T) -> T {
        let nibName = String(describing: type(of: view))
        let viewFromNib:T = Bundle.main.loadNibNamed(nibName,owner: nil,options: nil)?.first as! T
        return viewFromNib
    }
    
}

extension UIViewController {
    
    struct Holder {
        static var _myComputedProperty:CustomFailScreen?
    }
    
    var customView:CustomFailScreen? {
        get {
            return Holder._myComputedProperty
        }
        set(newValue) {
            Holder._myComputedProperty = newValue
        }
    }
    
    func showFailView(to superView: UIView,targetView:UIView,isEnternet:Bool, msg:String ,handler:@escaping ()->Void) {
        if self.customView == nil {
            self.customView = Bundle.main.loadNibNamed("CustomFailScreen",owner: nil,options: nil)?.first as? CustomFailScreen
        }
        customView?.setViewData(handler: handler)
        
        customView?.frame = targetView.frame
        customView?.statusImgView.image = isEnternet ? #imageLiteral(resourceName: "bg_no_internet") : #imageLiteral(resourceName: "bg_no_result")
        customView?.messageLAbel.text = msg
            //isEnternet ? "No internet connection" : "Sorry, There is no results here"
        customView?.reloadBtn.isHidden = isEnternet ? false : true
        superView.addSubview(customView!)
      
    }

    func hideFailView () {
        self.customView?.removeFromSuperview()
    }
}
