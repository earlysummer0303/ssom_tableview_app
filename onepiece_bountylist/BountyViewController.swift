//
//  BountyViewController.swift
//  onepiece_bountylist
//
//  Created by 황지우 on 2022/01/15.
//

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    let viewModel = BountyViewModel()
    
    
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
            // sender : 다른 뷰 컨트롤러로 그때그때 경우에 따라 보낼 정보
                let BountyInfo = viewModel.BountyInfoList[i]
                // 중요!! segue로 연결된 페이지의 viewModel에서 model:BountyInfo로 업데이트 시키자.
                vc?.viewModel.update(model: BountyInfo)
                
            }
        }
    }
    
    // UITableViewDataSource 프로토콜에 대한 응답
    // cell 개수는 몇개로 할거야?
    // 테이블 뷰를 어떻게 보여줄거야?
    
    //개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //cell 개수는 다섯개로 할거야
        return viewModel.numOFBountyInfoList
        
    }
    
    
    //표현
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 재활용할 cell을 "cell이라는 identifier로 분리할거야"
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell
        else{
            return UITableViewCell()
        }
        let bountyinfo = viewModel.BountyInfoList[indexPath.row]
        cell.update(info: bountyinfo)
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 딱히 특별하게 해줄 작업 없음
    }
    
    // UITableViewDelegate 프로토콜에 대한 응답
    // tableview를 클릭하면 어떡할까?
    
    func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath) {
        // 한 셀을 누르면(didSelectRowAt indexPath)
        //print ("--> \(BountyInfo[indexPath.row].name)")
        // 그 셀의 row 값을 print 할게.
        // 버튼이 눌릴때 호출되는 함수 - segue
        performSegue(withIdentifier: "showDetail" /* segue의 id(identifier)*/, sender: indexPath.row /*다른 페이지로 끼워보낼 정보*/)
    }

    
}

// custom cell
// cell 을 custom 하기 위해 UITableViewCell을 상속받는 새로운 클래스를 선언해준다.
class ListCell : UITableViewCell{
    // ListCell은 imageview, nameLabel, bountyLabel이라는 프로퍼티를 추가적으로 갖는다.
    @IBOutlet weak var imageview :UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var bountyLabel : UILabel!
    func update (info :BountyInfo) {
        imageview.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = info.bounty
    }
    
}

//리팩토링 - 모델
// 데이터의 구조를 나타내는(선언해주는) 부분
struct BountyInfo {
  // 뷰에서 필요한 데이터 : name, bounty, img
    let name : String
    let bounty: String
    // 이미지 파일이 없는 경우도 있을 수 있으니 이미지는 옵셔널로 접근한다.
    var image : UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init (name : String, bounty : String) {
        self.name = name
        self.bounty = bounty
    }
    
}

//리팩토링 - 뷰모델
class BountyViewModel {
    // 모델
    let BountyInfoList : [BountyInfo] = [
    
        BountyInfo(name:"산책쏨", bounty:"마실나온 쏨이" ),
        BountyInfo(name:"쩍벌쏨", bounty:"다리를 발라당 쏨이"),
        BountyInfo(name:"그린쏨", bounty:"풀 속 쏨이"),
        BountyInfo(name:"꽃개쏨", bounty:"꽃과 쏨이"),
        BountyInfo(name:"깁스쏨", bounty:"깁스했쏨ㅠㅠ"),
        BountyInfo(name:"휠체어쏨", bounty:"민서가 만든 휠체어"),
        BountyInfo(name:"뀨쏨", bounty:"뀨한 쏨 쩰리" ),
        BountyInfo(name: "모해쏨", bounty:"모해??" ),
        BountyInfo(name: "꽃꽂쏨", bounty:"귀에 꽃꽂아쏨" ),
        
    ]
    
    var numOFBountyInfoList: Int {
        return BountyInfoList.count
    }
}
