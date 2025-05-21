//
//  MBTIViewController.swift
//  BMI01-GSM
//
//  Created by SS on 12/8/24.
//

import UIKit

class MBTIViewController: UIViewController {

    var Cnt_E_I = 0
    var Cnt_S_N = 0
    var Cnt_T_F = 0
    var Cnt_J_P = 0
    
    var questionIndex = 0
    let questions = [
        "외향적(E)인가요, 내향적(I)인가요?", // 1번 질문
        "세부사항에 집중하는 편(S)인가요, 전체적인 맥락을 보는 편(N)인가요?", // 2번 질문
        "결정을 내릴 때 논리적 사고(T)를 중요하게 생각하나요, 감정을 중요하게 생각하나요(F)?", // 3번 질문
        "일정을 미리 계획하는 편(J)인가요, 즉흥적인 편(P)인가요?" // 4번 질문
    ]
    
    // UI 요소 (질문 표시 및 결과 레이블)
    @IBOutlet weak var lblquestion: UILabel!
    
    // 버튼 UI 요소
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBAction func btnReset(_ sender: UIButton) {
        // 성향 카운트 초기화
        Cnt_E_I = 0
        Cnt_S_N = 0
        Cnt_T_F = 0
        Cnt_J_P = 0
        
        // 질문 인덱스 초기화
        questionIndex = 0
        
        // 첫 번째 질문을 다시 보여줌
        displayQuestion()
        
        // 버튼 텍스트 초기화
        btnA.setTitle("외향적(E)", for: .normal)
        btnB.setTitle("내향적(I)", for: .normal)
        
        // 다시 시작 버튼 숨기기
        btnReset.isHidden = true
        
        // 질문 버튼 보이기
        btnA.isHidden = false
        btnB.isHidden = false
    }
    
    @IBAction func btnSelectA(_ sender: UIButton) {
        switch questionIndex {
        case 0: Cnt_E_I += 1
        case 1: Cnt_S_N += 1
        case 2: Cnt_T_F += 1
        case 3: Cnt_J_P += 1
        default: break
        }
        
        questionIndex += 1
        if questionIndex < questions.count {
            displayQuestion()
        } else {
            showResult()
        }
    }
    
    @IBAction func btnSelectB(_ sender: UIButton) {
        switch questionIndex {
        case 0: Cnt_E_I += 0
        case 1: Cnt_S_N += 0
        case 2: Cnt_T_F += 0
        case 3: Cnt_J_P += 0
        default: break
        }
        
        questionIndex += 1
        if questionIndex < questions.count {
            displayQuestion()
        } else {
            showResult()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnReset.isHidden = true
        // 질문 레이블 설정 (자동 줄바꿈을 지원하도록 설정)
        lblquestion.numberOfLines = 0 // 여러 줄 표시 허용
        lblquestion.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈
        
        // 첫 번째 질문을 표시
        displayQuestion()
    }

    // 현재 질문을 표시하는 함수
    func displayQuestion() {
        if questionIndex < questions.count {
            lblquestion.text = questions[questionIndex]
            
            // 버튼 텍스트 업데이트
            switch questionIndex {
            case 0: // 첫 번째 질문: E vs I
                btnA.setTitle("외향적(E)", for: .normal)
                btnB.setTitle("내향적(I)", for: .normal)
            case 1: // 두 번째 질문: S vs N
                btnA.setTitle("세부(S)", for: .normal)
                btnB.setTitle("전체(N)", for: .normal)
            case 2: // 세 번째 질문: T vs F
                btnA.setTitle("논리(T)", for: .normal)
                btnB.setTitle("감정(F)", for: .normal)
            case 3: // 네 번째 질문: J vs P
                btnA.setTitle("계획(J)", for: .normal)
                btnB.setTitle("즉흥(P)", for: .normal)
            default:
                break
            }
        }
    }

    // 최종 MBTI 결과를 계산하고 출력하는 함수
    func showResult() {
        var mbti = ""
        mbti += (Cnt_E_I > 0 ? "E" : "I")
        mbti += (Cnt_S_N > 0 ? "S" : "N")
        mbti += (Cnt_T_F > 0 ? "T" : "F")
        mbti += (Cnt_J_P > 0 ? "J" : "P")
        
        lblquestion.text = "당신의 MBTI는: \(mbti)"
        
        // 버튼을 보이게 합니다
        btnA.isHidden = true
        btnB.isHidden = true
        btnReset.isHidden = false
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
