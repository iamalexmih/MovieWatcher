//
//  ScreenSaverViewController.swift
//  ch 3 MovieWatcher
//
//  Created by Луиза Самойленко on 10.04.2023.
//

import UIKit
import SnapKit
import Lottie

class ScreenSaverViewController: UIViewController {
    let label = "Moviemax"
    let animation = "movieAnimation"

    lazy var moviemaxIcon = UIImageView()
    lazy var moviemaxLabel = UILabel()
    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let onBoardingVC = OnBoardingViewController()
            self.navigationController?.pushViewController(onBoardingVC, animated: true)
        }
    }

    private func configureUI() {
        view.backgroundColor = UIColor(named: Resources.Colors.accent)
        configureMoviemaxIcon()
        configureMoviemaxLabel()
        configureAnimation()
    }

    private func configureMoviemaxIcon() {
        view.addSubview(moviemaxIcon)
        moviemaxIcon.image = UIImage(named: Resources.Image.moviemaxIcon)
        moviemaxIcon.contentMode = .scaleAspectFill
        moviemaxIcon.layer.masksToBounds = true
        moviemaxIcon.snp.makeConstraints { make in
            make.height.width.equalTo(88)
            make.top.equalTo(268)
            make.centerX.equalToSuperview()
        }
    }

    private func configureMoviemaxLabel() {
        view.addSubview(moviemaxLabel)
        moviemaxLabel.text = label
        moviemaxLabel.font = .montserratRomanExtraBold(size: 32)
        moviemaxLabel.textColor = .white
        moviemaxLabel.textAlignment = .center
        moviemaxLabel.snp.makeConstraints { make in
            make.top.equalTo(moviemaxIcon.snp.bottom).inset(-24)
            make.centerX.equalToSuperview()
        }
    }

    private func configureAnimation() {
        animationView = .init(name: animation)
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1
        view.addSubview(animationView!)
        animationView!.play()

        animationView!.snp.makeConstraints { make in
            make.top.equalTo(moviemaxLabel.snp.bottom).inset(-240)
            make.height.width.equalTo(120)
            make.centerX.equalToSuperview()
        }
    }
}
