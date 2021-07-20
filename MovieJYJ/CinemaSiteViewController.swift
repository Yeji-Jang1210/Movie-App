//
//  cinemaSiteViewController.swift
//  MovieJYJ
//
//  Created by 소프트웨어컴퓨터 on 2021/06/10.
//

import UIKit
import WebKit

class CinemaSiteViewController: UIViewController {
    
    var SiteURL = ""
    @IBOutlet weak var CinemaSite: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = SiteURL
        guard let url = URL(string:urlString) else { return }
        let request = URLRequest(url:url)
        CinemaSite.load(request)        // Do any additional setup after loading the view.
    }

}
