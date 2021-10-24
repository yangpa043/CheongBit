//
//  ViewController.swift
//  CheongBit
//
//  Created by 짜미 on 2021/08/20.
//

import UIKit
import AVKit
import AVFoundation
import SoundAnalysis

class MainViewController: UIViewController {
    
// MARK: - 전역 변/상수
    
    // 경보 인식 스위치
    var switchONorOFF: Bool = false
    // 마이크 권한 상태
    var micPermissionStatus: Bool = true

// MARK: - Outlets
    
    @IBOutlet weak var locationSelectButton: mainViewNavButton!
    @IBOutlet weak var MLTableView: UITableView!
    @IBOutlet weak var micSwitch: UIButton!
    @IBOutlet weak var micImage: UIImageView!
    @IBOutlet weak var micStatusLabel: UILabel!
    @IBOutlet weak var micONandOFFStackView: UIStackView!
    
    
// MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchButtonUpdate()
        applyDynamicFont()
        requestMicrophonePermission()
        MLTableView.isHidden = true
        
        // 마이크 스텍뷰 디자인
        micONandOFFStackView.backgroundColor = #colorLiteral(red: 0, green: 0.4877254963, blue: 1, alpha: 1)
        micONandOFFStackView.layer.cornerRadius = micONandOFFStackView.frame.width/15
        micONandOFFStackView.layer.masksToBounds = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationSelectButton.setTitle(otherViewLocationData, for: .normal)
    }

// MARK: - Actions
    
    // 주소설정버튼
    @IBAction func locationSelectbuttonTapped(_ sender: UIButton) {
        print("locationButtonTapped")
    }
    
    // 마이크 스위치 버튼
    @IBAction func switchChanged(_ sender: UIButton) {
        if micPermissionStatus == false {
            switchONorOFF = true
            switchButtonUpdate()
        }
        switchButtonUpdate()
    }
    
    // 신고버튼
    @IBAction func reportButtonTapped(_ sender: UIButton) {
        
    }
    
// MARK: - Functions
    
    // 마이크 스위치 함수
    func switchButtonUpdate() {
        // 스위치가 꺼져있을 때
        if switchONorOFF == true{
            if micPermissionStatus == false {
                micCanceldAlert()
            }
            micSwitch.setImage(UIImage(named: "switchOn"), for: .normal)
            micImage.image = UIImage(named: "micOn")
            micStatusLabel.text = "화재경보음 인식 중"
            switchONorOFF = false
            // ML On
            MLTableView.isHidden = false
            prepareForRecording()
            createClassificationRequest()
        }
        // 스위치가 켜져있을 때
        else {
            micSwitch.setImage(UIImage(named: "switchOff"), for: .normal)
            micImage.image = UIImage(named: "micOff")
            micStatusLabel.text = "인식 중이 아님"
            switchONorOFF = true
            MLTableView.isHidden = true
            audioEngine.stop()
        }
    }
    
    // 다이나믹 폰트
    func applyDynamicFont() {
        locationSelectButton.titleLabel?.dynamicFont(fontSize: 20, weight: .regular)
        micStatusLabel.dynamicFont(fontSize: 24, weight: .bold)
    }
    
    // 마이크 권한
    func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                print("Mic: 권한 허용")
                self.micPermissionStatus = true
            } else {
                print("Mic: 권한 거부")
                self.micPermissionStatus = false
            }
        })
    }
    
    func micCanceldAlert() {
        let micCanceled = UIAlertController(title: "마이크 권한 요청", message: "마이크 권한이 거절 되었습니다.\n설정>CheongBit 에서 허용 해주세요.", preferredStyle: UIAlertController.Style.alert)
        let alertCancel = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel)
        let goToSetting = UIAlertAction(title: "설정", style: UIAlertAction.Style.default) { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
    
        micCanceled.addAction(alertCancel)
        micCanceled.addAction(goToSetting)
        
        self.present(micCanceled, animated: true)
    }
    
    func fireDetectAlert() {
        let micCanceled = UIAlertController(title: "화재가 발생하였습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
        let alertCancel = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel)

        micCanceled.addAction(alertCancel)
        
        self.present(micCanceled, animated: true)
    }



    
// MARK: - ML
// But Test
    private let audioEngine = AVAudioEngine()
    private var soundClassifier = fireAlarmSoundClassifier_6()
    var streamAnalyzer: SNAudioStreamAnalyzer!
    let queue = DispatchQueue(label: "TeamPdf.CheongBit", attributes: .concurrent)
    var results = [(label: String, confidence: Float)]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.MLTableView.reloadData()
            }
        }
    }
    
    private func startAudioEngine() {
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            showAudioError()
        }
    }
    
    private func prepareForRecording() {
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        streamAnalyzer = SNAudioStreamAnalyzer(format: recordingFormat)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            [unowned self] (buffer, when) in
            self.queue.async {
                self.streamAnalyzer.analyze(buffer,atAudioFramePosition: when.sampleTime)
            }
        }
        startAudioEngine()
    }
    
    private func createClassificationRequest() {
        do {
            let request = try SNClassifySoundRequest(mlModel: soundClassifier.model)
            try streamAnalyzer.add(request, withObserver: self)
        } catch {
            fatalError("error adding the classification request")
        }
    }

}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "ResultCell")
        }
        
        let result = results[indexPath.row]
        let label = convert(id: result.label)
        cell!.textLabel!.text = "\(label): \(result.confidence)"
        return cell!
    }
    
    private func convert(id: String) -> String {
        let mapping = ["fireAlarm" : "fireAlarm", "normal" : "normal", "talkingSound" : "talkingSound"]
        return mapping[id] ?? id
    }
    
}

extension MainViewController: SNResultsObserving {
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult else { return }
        var temp = [(label: String, confidence: Float)]()
        let sorted = result.classifications.sorted { (first, second) -> Bool in
            return first.confidence > second.confidence
        }
        for classification in sorted {
            let confidence = classification.confidence * 100
            if confidence > 5 {
                temp.append((label: classification.identifier, confidence: Float(confidence)))
//                if classification.identifier == "fireAlarm"/*.contains("fire")*/ {
//                    fireDetectAlert()
//                }
            }
            results = temp
        }
    }
}

extension MainViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAudioError() {
        let errorTitle = "Audio Error"
        let errorMessage = "Recording is not possible at the moment."
        self.showAlert(title: errorTitle, message: errorMessage)
    }
    
}
// ML end