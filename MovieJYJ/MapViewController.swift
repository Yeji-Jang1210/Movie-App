//
//  MapViewController.swift
//  MovieJYJ
//
//  Created by 소프트웨어컴퓨터 on 2021/06/01.
//

import UIKit
//webView사용을 위한 WebKit포함
import WebKit

class MapViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //한글이 들어간 URL은 인식에 오류가 있음->.urlQueryAllowed를 사용해
        //쿼리 URL구성 요소에 허용되는 문자집합 반환
       let urlKorString = "https://map.naver.com/v5/search/영화관"
        let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string:urlString) else { return }
        let request = URLRequest(url:url)
        webView.load(request)
        
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
