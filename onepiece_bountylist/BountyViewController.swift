//
//  BountyViewController.swift
//  onepiece_bountylist
//
//  Created by 황지우 on 2022/01/15.
//

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    let nameList = ["산책쏨","쩍벌쏨", "그린쏨", "꽃개쏨", "깁스쏨", "휠체어쏨", "뀨쏨", "모해쏨", "꽃꽂쏨"]
    let bountyList = ["마실나온 쏨이","다리를 발라당 쏨이", "풀 속 쏨이","꽃과 쏨이", "깁스했쏨ㅠㅠ","민서가 만든 휠체어", "모해??","뀨한 쏨 쩰리", "귀에 꽃꽂아쏨"]
    // UITableViewDataSource 프로토콜에 대한 응답
    // cell 개수는 몇개로 할거야?
    // 테이블 뷰를 어떻게 보여줄거야?
    
    // 세그웨이가 실행되기 전 준비하는 함수
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
       //detailviewcontroller 에게 데이터 줄거야
        if segue.identifier == "showDetail" {
            // 세그웨이의 종착지가 디테일 뷰 컨트롤러이다.
            let vc = segue.destination as? DetailViewController
            
            if let i = sender as? Int {
                vc?.name = nameList[i] // bounty 랑 name 이라는 변수명으로 디테일뷰 컨트롤러로 넘어가쥬
                vc?.bounty = bountyList[i]
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //cell 개수는 다섯개로 할거야
        return bountyList.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 재활용할 cell을 "cell이라는 identifier로 분리할거야"
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell
        else{
            return UITableViewCell()
        }
        // indexPath : 각 셀의 위치 (순서)
        let img = UIImage(named:"\(nameList[indexPath.row]).jpg")
        // 각각의 인덱스에 대해 같은 이름을 가진 이미지를 세팅하기
        cell.imageview.image = img
        cell.nameLabel.text = nameList[indexPath.row]
        cell.bountyLabel.text = bountyList[indexPath.row]
        
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // UITableViewDelegate 프로토콜에 대한 응답
    // tableview를 클릭하면 어떡할까?
    
    func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath) {
        // 한 셀을 누르면(didSelectRowAt indexPath)
        print ("--> \(nameList[indexPath.row])")
        // 그 셀의 row 값을 print 할게.
        // 버튼이 눌릴때 호출되는 함수 - segue
        performSegue(withIdentifier: "showDetail" /* segue의 id(identifier)*/, sender: indexPath.row /*다른 페이지로 끼워보낼 정보는 없음*/)
    }

    
}

// custom cell
class ListCell : UITableViewCell{
    @IBOutlet weak var imageview :UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var bountyLabel : UILabel!
    
}
