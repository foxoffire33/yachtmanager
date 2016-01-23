//
//  YachtViewController.swift
//  pageBasedYachtmanager
//
//  Created by Reinier on 20-01-16.
//  Copyright © 2016 Reinier. All rights reserved.
//

import UIKit

class YachtViewController: UIViewController {
    
    var model:YachtModel?
    var index = 0
    @IBOutlet weak var yachtTitle: UILabel!
    
    @IBOutlet weak var labelModelId: UILabel!
    @IBOutlet weak var labelSailNumber: UILabel!
    @IBOutlet weak var labelYearBuild: UILabel!
    @IBOutlet weak var labelCallsign: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var lebelLength: UILabel!
    @IBOutlet weak var labelWidth: UILabel!
    @IBOutlet weak var labelHeight: UILabel!
    @IBOutlet weak var labelDepth: UILabel!
    @IBOutlet weak var labelWeight: UILabel!
    
    @IBOutlet weak var titleInNavBar: UINavigationItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var pageViewController: UIPageViewController!
    var yachtModels: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setbackground
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "appbg")?.drawInRect(self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        //setting labels
        if self.model?.name != nil{
            self.yachtTitle.text = "\(model!.name!)"
        }
        if self.model?.model_id != nil{
            let label = model!.getLabelLable("model_id")!
            self.labelModelId.text = "\(label): \(model!.model_id!)"
        }
        if self.model?.sail_number != nil{
            let label = model!.getLabelLable("sail_number")!
            self.labelSailNumber.text = "\(label): \(model!.sail_number!)"
        }
        if self.model?.year_build != nil{
            let label = model!.getLabelLable("year_build")!
            self.labelYearBuild.text = "\(label): \(model!.year_build!)"
        }
        if self.model?.callsign != nil{
            let label = model!.getLabelLable("callsign")!
            self.labelCallsign.text = "\(label): \(model!.callsign!)"
        }
        if self.model?.type != nil{
            let label = model!.getLabelLable("type")!
            self.labelType.text = "\(label): \(model!.type!)"
        }
        if self.model?.length != nil{
            let label = model!.getLabelLable("length")!
            self.lebelLength.text = "\(label): \(model!.length!)"
        }
        if self.model?.width != nil{
            let label = model!.getLabelLable("width")!
            self.labelWidth.text = "\(label): \(model!.width!)"
        }
        if self.model?.height != nil{
            let label = model!.getLabelLable("height")!
            self.labelHeight.text = "\(label): \(model!.height!)"
        }
        if self.model?.depth != nil{
            let label = model!.getLabelLable("depth")!
            self.labelDepth.text = "\(label): \(model!.depth!)"
        }
        if self.model?.weight != nil{
            let label = model!.getLabelLable("weight")!
            self.labelWeight.text = "\(label): \(model!.weight!)"
        }
        print(index)
        scrollView.contentSize.height = CGFloat(600)
        scrollView.addSubview(self.maintenanceInfoBox("MaintenanceOne",top:500))
        scrollView.addSubview(self.maintenanceInfoBox("MaintenanceTwo",top:620))
        scrollView.scrollEnabled = true
        scrollView.alwaysBounceVertical = true
    }
    
    func maintenanceInfoBox(text:String,top:CGFloat) -> UIView {
        let maintenanceInfoBoxView : UIView = UIView(frame: CGRectMake(0,top,320,100))
        self.scrollView.contentInset.bottom = 180
        print(self.scrollView.contentSize.height)
        //add name label
        let label = UILabel(frame: CGRect(x: 20,y: 20,width: maintenanceInfoBoxView.frame.width,height: maintenanceInfoBoxView.frame.height))
        label.text = text
        maintenanceInfoBoxView.addSubview(label)
        //add con touche
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
      //  tap.delegate = self
        maintenanceInfoBoxView.addGestureRecognizer(tap)
        //long press
        let lpgr = UILongPressGestureRecognizer(target: self, action: "showOptionMenu:")
        maintenanceInfoBoxView.addGestureRecognizer(lpgr)
        
        //return view
        return maintenanceInfoBoxView
    }
    
    func showOptionMenu(gestureRecognizer:UIGestureRecognizer) {
        let alertController = UIAlertController(title: "wat wilt u doen?", message: nil, preferredStyle: .ActionSheet)
        
        let defaultAction = UIAlertAction(title: "Verwijderen", style: .Default, handler:  {(alert: UIAlertAction!) in self.deleteMaintenanceAction() })
        alertController.addAction(defaultAction)
        let updateAction = UIAlertAction(title: "Bewerken", style: .Default, handler: nil)
        alertController.addAction(updateAction)
        let deleteAction = UIAlertAction(title: "Annuleren", style: .Cancel, handler: nil)
        alertController.addAction(deleteAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func deleteMaintenanceAction(){
        let restApi = RestApiManager()
        restApi.httpDeleRequesttWithAccessToken("yachts/46",token:"vg48AeVddfWh_hqHzFk8v4WvMq4IX_ng") { (completed) -> Void in
            if completed {
                print("gefix")
            }
            /*dispatch_async(dispatch_get_main_queue()) {
                self.setupUI()
            }*/
            
        }
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("tapped")
        //open maintenance view
        self.performSegueWithIdentifier("fromYachtViewControllerToMaintenanceViewController", sender: self)
    }
}
