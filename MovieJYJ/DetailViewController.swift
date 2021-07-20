//
//  DetailViewController.swift
//  MovieJYJ
//
//  Created by 소프트웨어컴퓨터 on 2021/06/01.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    var movieName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //nameLabel.text = movieName
        navigationItem.title = movieName
        //url뒤에 해당 row의 영화 이름을 추가
        let urlKorString = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query="+movieName
        //쿼리 URL구성 요소에서 허용되는 문자 집합을 반환한다.
        let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string:urlString) else { return }
        let request = URLRequest(url:url)
        webView.load(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
