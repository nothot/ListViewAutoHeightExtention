//
//  ViewController.swift
//  ListViewAutoHeightExtention
//
//  Created by nothot on 03/31/2021.
//  Copyright (c) 2021 nothot. All rights reserved.
//

import UIKit
import ListViewAutoHeightExtention

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mUICollectionViewCell", for: indexPath) as? TestCollectionViewCell ?? TestCollectionViewCell()
        
        let text = datas[indexPath.item]
        cell.render(with: text)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = datas[indexPath.item]
        let size = collectionView.sizeForItem(identifier: "mUICollectionViewCell", indexPath: indexPath, cacheByKey: text.hash) { cell in
            
            let mCell = cell as? TestCollectionViewCell ?? TestCollectionViewCell()
            
            mCell.render(with: text)

        }
        print("---size \(size)")
        return size
    }
    

    lazy var collectionView = buildCollectionView()
    
    lazy var datas = buildDatas()
    
    func buildCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 0
        let rect = CGRect(x: 0, y: 44, width: view.bounds.width, height: view.bounds.height - 44)
        let collection = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
        return collection
    }
    
    func buildDatas() -> [String] {
        
        return [
            "1  武当三侠俞岱岩施展轻功在苍翠青山之中飞走，来到松溪畔饮水，看到此处风景秀美，俞岱岩露出笑容。松溪畔破屋之中有人正在毁掉宝刀",
            "0  几个人同时感到抢夺宝刀",
            "2  毁掉了煅刀的火炉。俞岱岩飞身来到屋外往里看去，发现里面有个白袍人功夫奇高，且出手狠辣，其余人都不是他的对手，被白袍不是折断手臂就是震碎心脏。俞岱岩心存仁善出手救了一个怀抱宝刀之人。白袍看出俞岱岩功夫出自武当，讽刺武当也来这里抢夺宝刀",
            "3  俞岱岩解释自己只是路过，遇到不平事来管闲事而已。白袍让俞岱岩让去攻向怀抱宝刀之人",
            "4  可持刀人宁死不拿着宝刀换药，俞岱岩也管不了许多就要离开。持刀人抱住了俞岱岩的腿，声称可以把屠龙刀好处告诉俞岱岩",
            "5  只是却并未找到屠龙刀，白眉殷野王带人继续追赶抢走宝刀之人。俞岱岱岩眼中含泪。俞岱岩拔出屠龙刀，一时不知屠龙刀是福还是祸，它的出现害死了太多人，俞岱岩决定带着屠龙刀回武当山交给师傅张三丰处置",
            "3  俞岱岩解释自己只是路过，遇到不平事来管闲事而已。白袍让俞岱岩让去攻向怀抱宝刀之人",
            "6  张翠山追问是否是殷素素给龙门镖局托镖，是否知道俞岱岩出事，殷素素都承认了，并且还请张翠山进入船舱。殷素素向张翠山承认当初托镖护送俞岱岩回去的人正是她",
            "4  可持刀人宁死不拿着宝刀换药，俞岱岩也管不了许多就要离开。持刀人抱住了俞岱岩的腿，声称可以把屠龙刀好处告诉俞岱岩",
            "7  托镖之后殷素素放心不下还特地跟在都大锦等人身后，亲眼看见都大锦把俞岱岩交给了六个人。殷素素担心有诈就在后面跟着，发现那些人要害俞岱岩，殷素素挺身而出和人搏斗，不曾想却中了对方少林梅花镖暗器。殷素素还让张翠山看了自己手臂上的三枚毒镖，殷素素胳膊中毒明显发紫血脉喷张，也是触目惊心殷素素后来发现张翠山跟着都大锦他们，路过锦州时候亲眼看见张翠山不满都大锦等人大吃大喝，而百姓正在闹饥荒流离失所",
            "1  武当三侠俞岱岩施展轻功在苍翠青山之中飞走，来到松溪畔饮水，看到此处风景秀美，俞岱岩露出笑容。松溪畔破屋之中有人正在毁掉宝刀",
            "几个人同时感到抢夺宝刀",
            "8  殷素素声称自己看见张翠山衣服穿得漂亮就弄了一模一样的衣服穿着",
            "9  张翠山出来船舱之后终究不忍心，他知道殷素素胳膊再不治疗就危及性命，不管怎么说她也是护送俞岱岩回去的人。张翠山强忍怒火向殷素素道歉，殷素素这才露出笑脸让张翠山医治。随后，殷素素依依不舍送别了张翠山。"
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: "mUICollectionViewCell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(44)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

