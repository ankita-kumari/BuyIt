//
//  WebViewController.swift
//  Todo
//
//  Created by Ankita Kumari on 15/10/15.
//  Copyright © 2015 Marcus Molchany. All rights reserved.
//

import Foundation
import UIKit

class WebViewController: UIViewController{
    var url = NSURL(string :"")
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
 
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        print("Unwinding")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
}
