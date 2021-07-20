//
//  CinemaViewController.swift
//  MovieJYJ
//
//  Created by 소프트웨어컴퓨터 on 2021/06/10.
//

import UIKit

class CinemaViewController: UIViewController {
    var cinemaSite = ""
    @IBAction func actLotteCinema(_ sender: UIButton) {
        cinemaSite = "https://www.lottecinema.co.kr/NLCMW"
    }
    @IBAction func actCGV(_ sender: UIButton) {
        cinemaSite = "https://m.cgv.co.kr"    }
    @IBAction func actMegaBox(_ sender: UIButton) {
        cinemaSite = "https://m.megabox.co.kr"    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let dest = segue.destination as? CinemaSiteViewController else{ return }
        
        dest.SiteURL = cinemaSite
    }
    
}
