//
//  drawAnimalViewController.swift
//  BMI01-GSM
//
//  Created by SS on 12/8/24.
//

import UIKit

class drawAnimalViewController: UIViewController {

    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var txtLineSize: UITextField!
    
    var lastPoint: CGPoint!
    var lineSize: CGFloat = 2.0
    var lineColor = UIColor.red.cgColor
    
    // 동물 배경 이미지 추가
    var animalImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경 이미지 설정
        setupBackgroundImage()
        
        // 초기 선 크기 설정
        txtLineSize.text = String(Int(lineSize))
    }
    
    // 배경으로 동물 그림을 설정하는 함수
    func setupBackgroundImage() {
        // 프로젝트에 추가한 동물 이미지 파일을 UIImage로 불러오기
        let animalImage = UIImage(named: "draw_img_1.png") // "draw_img_1.png"는 프로젝트에 추가된 이미지 파일 이름
        
        // 이미지가 정상적으로 불러와졌다면
        if let image = animalImage {
            animalImageView = UIImageView(image: image)
            animalImageView.frame = imgView.bounds // imgView의 크기에 맞게 배경 설정
            animalImageView.contentMode = .scaleAspectFit // 비율에 맞게 이미지 크기 조정
            animalImageView.alpha = 0.5 // 배경 이미지를 반투명하게 설정 (0은 완전 투명, 1은 불투명)
            animalImageView.isHidden = false // 처음에 배경이 보이도록 설정
            imgView.addSubview(animalImageView) // imgView의 하위 뷰로 배경 이미지 추가
        }
    }
    
    // 배경 이미지 숨기기/보이기 버튼
    @IBAction func toggleBackground(_ sender: UIButton) {
        animalImageView.isHidden = !animalImageView.isHidden
    }
    
    // 그림 초기화
    @IBAction func btnClearImageView(_ sender: UIButton) {
        imgView.image = nil
        animalImageView.isHidden = false // 배경 이미지는 초기화 시에도 보이게 설정
    }
    
    // 터치 시작
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        lastPoint = touch.location(in: imgView)
    }
    
    // 터치 이동 (그리기)
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        
        // 배경을 그리기 전에 그려진 내용을 유지
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        // 그리기 설정
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        let touch = touches.first!
        let currPoint = touch.location(in: imgView)
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        // 그려진 내용을 새로운 이미지로 설정
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currPoint
    }
    
    // 터치 끝 (그리기 종료)
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        
        // 배경을 그리기 전에 그려진 내용을 유지
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        // 그리기 설정
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        // 터치가 끝난 지점에도 마지막 선을 그립니다.
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        // 그려진 내용을 새로운 이미지로 설정
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    // 흔들어서 그림 지우기
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            imgView.image = nil
        }
    }
    
    // 선 크기 변경
    @IBAction func txtEditChange(_ sender: UITextField) {
        if let text = txtLineSize.text, let newSize = Int(text) {
            lineSize = CGFloat(newSize)
        }
    }
    
    // 텍스트 필드 종료 시 선 크기 적용
    @IBAction func txtDidEndOnExit(_ sender: UITextField) {
        if let text = txtLineSize.text, let newSize = Int(text) {
            lineSize = CGFloat(newSize)
        }
    }
    
    // 텍스트 필드 클릭 시 모두 선택
    @IBAction func txtTouchDown(_ sender: UITextField) {
        txtLineSize.selectAll(nil)
    }
    
    // 선 색상 변경 (검정색)
    @IBAction func btnChangeLineColorBlack(_ sender: UIButton) {
        lineColor = UIColor.black.cgColor
    }
    
    // 선 색상 변경 (빨간색)
    @IBAction func btnChangeLineColorRed(_ sender: UIButton) {
        lineColor = UIColor.red.cgColor
    }
    
    // 선 색상 변경 (초록색)
    @IBAction func btnChangeLineColorGreen(_ sender: UIButton) {
        lineColor = UIColor.green.cgColor
    }
    
    // 선 색상 변경 (파란색)
    @IBAction func btnChangeLineColorBlue(_ sender: UIButton) {
        lineColor = UIColor.blue.cgColor
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
