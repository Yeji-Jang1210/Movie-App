//
//  ViewController.swift
//  MovieJYJ
//
//  Created by 소프트웨어컴퓨터 on 2021/05/24.
//

import UIKit

let name = ["aaa","bbb","ccc","ddd","eee"]
struct MovieData : Codable{
    let boxOfficeResult : BoxOfficeResult
}
struct BoxOfficeResult : Codable{
    let dailyBoxOfficeList : [DailyBoxOfficeList]
}
struct DailyBoxOfficeList : Codable{
    let movieNm : String
    let audiCnt : String
    let rank : String
    let rankInten : String
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    var movieData : MovieData?
    var movieURL = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=2be0eea1573fd8856398115845381a81&targetDt="//20210525
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        movieURL += makeYesterdayString()
        getData()
    }
    func makeYesterdayString() -> String
    {
        let y = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let dateF = DateFormatter()
        dateF.dateFormat = "yyyyMMdd"
        let day = dateF.string(from: y)
        
        return day
    }
    func getData(){
        //1. URL 만들기
        if let url = URL(string:movieURL){
            //2. Session만들기
            let session = URLSession(configuration:.default)
            //3. URLSession 인스턴스에게 task주기
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let JSONdata = data{ //data is Optional Type
                    //print(JSONdata)
                    let dataString = String(data:JSONdata,encoding: .utf8)
                    print(dataString!)
                    let decoder = JSONDecoder()
                    do{ //error handling
                        let decodeData = try decoder.decode(MovieData.self, from: JSONdata)  //.self : static metatype
                        print(decodeData.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
                        print(decodeData.boxOfficeResult.dailyBoxOfficeList[0].audiCnt)
                        self.movieData = decodeData //uses self. inside closure
                        DispatchQueue.main.async{
                            self.table.reloadData()
                        }
                    }catch{
                        print(error)
                    }
                }
            }
            //task 시작하기(task.resume())
            task.resume()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* let dest = segue.destination as! DetailViewController   //segue.destination을 DetailViewController형으로 캐스팅
        dest.movieName = "영화이름" */
        guard let dest = segue.destination as? DetailViewController else{ return }
        //dest.movieName = "영화이름"
        let myIndexPath = table.indexPathForSelectedRow!
        let row = myIndexPath.row
        //print(row)
        
        dest.movieName = (movieData?.boxOfficeResult.dailyBoxOfficeList[row].movieNm)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = movieData?.boxOfficeResult.dailyBoxOfficeList.count else { return 0 }
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        cell.movieRank.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rank
        cell.rankIntencnt.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rankInten
        if let cnt = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiCnt{
            let numF = NumberFormatter()
            numF.numberStyle = .decimal
            let aCount = Int(cnt)!
            let result = numF.string(for:aCount)!+" 명"
            cell.movAudiCnt.text = "누적 관람객 수 : \(result)"
        }
        rankColor(cell : cell)
        loadRankInTenImg(cell : cell)
        return cell
    }
    func tableView(_ tableView : UITableView, heightForRowAt indexPath : IndexPath)->CGFloat{
        return 100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.description)
    }
    func tableView(_ tableView : UITableView, titleForHeaderInSection section:Int)->String?{
        return "박스오피스(영화진흥위원회제공:"+makeYesterdayString()+")"
    }
    func rankColor(cell : MyTableViewCell){
        if let c = cell.movieRank.text
        {
            switch Int(c)
            {
                case 1:
                    cell.movieRank.backgroundColor = UIColor(red: 255/255, green: 84/255, blue: 69/255, alpha: 1.0)
                case 2:
                    cell.movieRank.backgroundColor = UIColor(red: 255/255, green: 168/255, blue: 69/255, alpha: 1.0)
                case 3:
                    cell.movieRank.backgroundColor = UIColor(red: 255/255, green: 224/255, blue: 69/255, alpha: 1.0)
                default:
                    cell.movieRank.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
            }
        }
    }
    func loadRankInTenImg(cell:MyTableViewCell){
        var imgName : String = ""
        guard let c = Int(cell.rankIntencnt.text!) else { return }
        if(c > 0){
            imgName = "up.png"
        }else if(c < 0){
            imgName = "down.png"
        }else{
            imgName = "zero.png"
        }
        cell.rankIntenimg?.image = UIImage(named: imgName)
    }
}


