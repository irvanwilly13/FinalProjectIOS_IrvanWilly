
import UIKit
import AVFoundation
import Lottie


class ConfirmPaymentViewController: UIViewController {
    
    @IBOutlet weak var successLotieView: UIView!
    @IBOutlet weak var labelSuccess: UILabel!
    @IBOutlet weak var backToDashboardButton: UIButton!
    @IBOutlet weak var viewDetailButton: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    var lottieFiles = LottieAnimationView(name: "lottieSuccess")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        playSound()

    }
    func setup() {
        backToDashboardButton.addTarget(self, action: #selector(actionToHome), for: .touchUpInside)
        
        viewDetailButton.setCornerRadius(16)
        backToDashboardButton.setCornerRadius(16)
        
        lottieFiles.frame = successLotieView.bounds
        lottieFiles.contentMode = .scaleAspectFit
        //lottieFiles.loopMode = .loop
        lottieFiles.animationSpeed = 0.5
        successLotieView.addSubview(lottieFiles)
        lottieFiles.play()
    }
    @objc func actionToHome() {
        let vc = DashboardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func playSound() {
            // Gunakan nama file audio tanpa extension karena sudah ada di resources
            if let url = Bundle.main.url(forResource: "successPayment", withExtension: "mp3") {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.prepareToPlay()
                    audioPlayer?.play()
                } catch {
                    print("Error loading audio file: \(error.localizedDescription)")
                }
            } else {
                print("Audio file 'successPayment.mp3' not found in module resources.")
            }
        }
}
