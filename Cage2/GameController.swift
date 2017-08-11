//
//  檔名： GameController.swift
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
import GameplayKit

class GameController: UIViewController {
    //MARK: 屬性
    var cagePos = [[0,0], [1,0], [0,1], [1,1]]
    var cageExternal = [[0,-1], [1,-1], [2,0], [2,1], [0,2], [1,2], [-1,1], [-1,0]]
    var position = [0,0]
    var escapePos = [-1,-1]
    
    var animal = #imageLiteral(resourceName: "elephant01")
    var cageCorner = #imageLiteral(resourceName: "empty")
    var hurt = 0
    var success = -1
    
    //結果頁面
    let resultScene = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "Result") as! ResultController
    //委派類別
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    
    //MARK: 視窗屬性
    @IBOutlet weak var cage00: UIImageView!
    @IBOutlet weak var cage10: UIImageView!
    @IBOutlet weak var cage01: UIImageView!
    @IBOutlet weak var cage11: UIImageView!
    @IBOutlet weak var display: UILabel!
    
    //MARK: 視窗方法
    
    //往上一步
    @IBAction func upMethod(_ sender: UIButton) {
        if escapeHole(position[0], position[1] + 1) {
            position[1] += 1
            showSuccess()
        }
        else {
            if hit(position[0], position[1] + 1) {
                position[1] += 1
                promptMessage()
            }
        }
        
        showAnimal()
    }
    
    //往下一步
    @IBAction func downMethod(_ sender: UIButton) {
        if escapeHole(position[0], position[1] - 1) {
            position[1] -= 1
            showSuccess()
        }
        else {
            if hit(position[0], position[1] - 1) {
                position[1] -= 1
                promptMessage()
            }
        }
        
        showAnimal()
    }
    
    //往左一步
    @IBAction func leftMethod(_ sender: UIButton) {
        if escapeHole(position[0] - 1, position[1]) {
            position[0] -= 1
            showSuccess()
        }
        else {
            if hit(position[0] - 1, position[1]) {
                position[0] -= 1
                promptMessage()
            }
        }
        
        showAnimal()
    }
    
    //往右一步
    @IBAction func rightMethod(_ sender: UIButton) {
        if escapeHole(position[0] + 1, position[1]) {
            position[0] += 1
            showSuccess()
        }
        else {
            if hit(position[0] + 1, position[1]) {
                position[0] += 1
                promptMessage()
            }
        }
        
        showAnimal()
    }
    
    //MARK: 方法
    
    //遊戲勝利處理
    func showSuccess() {
        //成功脫逃
        resultScene.result = true
        
        //轉移到結果頁面
        appDelegate.window?.rootViewController = resultScene
    }
    
    //於顯示圖片
    func showAnimal() {
        let x = position[0]
        let y = position[1]
        switch (x, y) {
        case (0, 0):
            cage01.image = cageCorner
            cage11.image = cageCorner
            cage00.image = animal
            cage10.image = cageCorner
        case (0, 1):
            cage01.image = animal
            cage11.image = cageCorner
            cage00.image = cageCorner
            cage10.image = cageCorner
        case (1, 0):
            cage01.image = cageCorner
            cage11.image = cageCorner
            cage00.image = cageCorner
            cage10.image = animal
        case (1, 1):
            cage01.image = cageCorner
            cage11.image = animal
            cage00.image = cageCorner
            cage10.image = cageCorner
        default:
            cage01.image = cageCorner
            cage11.image = cageCorner
            cage00.image = cageCorner
            cage10.image = cageCorner
        }
    }
    
    //顯示提示訊息
    func promptMessage() {
        let x = position[0]
        let y = position[1]
        let dx = escapePos[0]
        let dy = escapePos[1]
        
        if dx == x {
            display.text = ""
        }
        else {
            if dx > x {
                display.text = "往右"
            }
            else {
                display.text = "往左"
            }
        }
        
        if dy == y {
            display.text? += ""
        }
        else {
            if dy > y {
                display.text? += "往上"
            }
            else {
                display.text? += "往下"
            }
        }
    }
    
    //判斷傷害程度
    func hurtImage() {
        switch hurt {
        case 0:
            animal = #imageLiteral(resourceName: "elephant01")
        case 1:
            animal = #imageLiteral(resourceName: "elephant02")
        case 2:
            animal = #imageLiteral(resourceName: "elephant03")
        default:
            appDelegate.window?.rootViewController = resultScene
        }
    }
    
    //判斷是否脫逃
    func escapeHole(_ newX: Int, _ newY: Int) -> Bool {
        if newX == escapePos[0] && newY == escapePos[1] {
            return true
        }
        else {
            return false
        }
    }
    
    //判斷是否碰撞籠子邊緣
    func hit(_ newX: Int, _ newY: Int) -> Bool {
        if newX < 0 || newX > 1 || newY < 0 || newY > 1 {
            hurt += 1
            hurtImage()
            return false
        }
        else {
            return true
        }
    }
    
    //MARK: 預設方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cagePos = (GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cagePos) as? [[Int]])!
        cageExternal = (GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cageExternal) as? [[Int]])!
        
        //隨機設定動物及脫逃座標
        position = cagePos[0]
        escapePos = cageExternal[0]
        showAnimal()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

