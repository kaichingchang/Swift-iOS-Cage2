//
//  檔名： ResultController.swift
//  專案： Cage2
//
//  《Swift 入門指南》 V3.00 的範例程式
//  購書連結
//         Google Play  : https://play.google.com/store/books/details?id=AO9IBwAAQBAJ
//         iBooks Store : https://itunes.apple.com/us/book/id1079291979
//         Readmoo      : https://readmoo.com/book/210034848000101
//         Pubu         : http://www.pubu.com.tw/ebook/65565?apKey=576b20f092
//
//  作者網站： http://www.kaiching.org
//  電子郵件： kaichingc@gmail.com
//
//  作者： 張凱慶
//  時間： 2017/08/10
//

import UIKit

class ResultController: UIViewController {
    //MARK: 屬性
    var result = false
    
    //MARK: 視窗屬性
    @IBOutlet weak var resultMessage: UILabel!
    
    //MARK: 預設方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if result {
            resultMessage.text = "我自由了，謝謝你！"
        }
        else {
            resultMessage.text = "頭昏眼花，我要暈過去了 ⊙_⊙"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

