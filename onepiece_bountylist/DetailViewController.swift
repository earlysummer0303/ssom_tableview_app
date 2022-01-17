//
//  DetailViewController.swift
//  onepiece_bountylist
//
//  Created by 황지우 on 2022/01/15.
//

import UIKit

// segue를 통해 name이라는 변수명으로 nameList[index], bounty라는 변수명으로 bountyList[index] 받아왔음.

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageview :UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var bountyLabel : UILabel!
    
    /*
    var bountyinfo : BountyInfo?
    
    var name : String?
    var bounty : String?
    */
    
    let viewModel = detailViewModel()

    override func viewDidLoad() {
        // 뷰가 메모리에 로드되고, 화면에 뜨기 수행해야할 추가적인 작업
        super.viewDidLoad()
        updateUI() // 내가 이거 안적어서 계속 뷰가 업데이트 안되었다..
        nameLabel.adjustsFontSizeToFitWidth = true
        bountyLabel.adjustsFontSizeToFitWidth = true
    }
    
    func updateUI(){// 받아오는 정보에 따라 ui를 업데이트 하는 기능
        
        if let bountyinfo = self.viewModel.bountyinfo{
            
            let img = UIImage(named:"\(bountyinfo.name).jpg")
            imageview.image = img
            nameLabel.text = bountyinfo.name
            bountyLabel.text = bountyinfo.bounty
            
        }
        
        
        
    }
    

    @IBAction func close(_ sender: Any) {
        dismiss(animated:true , completion:nil)
    }
    
}

class detailViewModel {
    
    var bountyinfo : BountyInfo?
    
    // 중요!!!! 업데이트 함수
    func update (model:BountyInfo?) {
        bountyinfo = model
    }
}
