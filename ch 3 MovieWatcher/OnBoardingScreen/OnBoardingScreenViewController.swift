//
//  OnBoardingScreenViewController.swift
//  Ch 3 MovieWatcher
//
//  Created by Алексей Попроцкий on 02.04.2023.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIViewController {

    lazy var backgroundImageView = UIImageView()
    lazy var personImageView = UIImageView()
    lazy var pageContainerView = UIView()
    lazy var pageScrollView = UIScrollView()
    lazy var pageChangeButton = CustomButton(title: "Continue")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: Resources.Colors.accent)
        configureBackgroundImages()
        configurepersonImageView()
        configurePageContainerView()
        configurePages(OnBoardingPage.all)
    }

    private func configureBackgroundImages() {
        view.addSubview(backgroundImageView)
        backgroundImageView.image = UIImage(named: Resources.Image.onBoardingIcons)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(25)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(240)
        }
    }

    private func configurepersonImageView() {
        view.addSubview(personImageView)
        personImageView.image = UIImage(named: Resources.Image.personImage)
        personImageView.snp.makeConstraints { make in
            make.height.equalTo(408)
            make.top.equalToSuperview().inset(44)
            make.centerX.equalToSuperview()
        }
    }

    private func configurePageContainerView() {
        view.addSubview(pageContainerView)
        pageContainerView.addSubview(pageScrollView)
        pageContainerView.addSubview(pageChangeButton)
        pageChangeButton.layer.masksToBounds = true
        pageChangeButton.layer.cornerRadius = 28
        pageContainerView.backgroundColor = UIColor(named: Resources.Colors.backGround)
        pageContainerView.layer.masksToBounds = true
        pageContainerView.layer.cornerRadius = 16
        pageScrollView.isPagingEnabled = true
        pageScrollView.showsHorizontalScrollIndicator = false
        pageContainerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(personImageView.snp.bottom).inset(6)
            make.bottomMargin.equalToSuperview().inset(46)
        }
        pageScrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(60)
            make.bottom.equalToSuperview().inset(108)
        }
        pageChangeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.width.equalTo(200)
            make.bottom.equalToSuperview().inset(28)
        }

    }

    private func configurePages(_ pages: [OnBoardingPage]) {
        pageScrollView.subviews.forEach { $0.removeFromSuperview() }
        let pageViews = pages.map { page in
            let pageView = OnBoardingPageView()
            pageView.configure(onboarding: page)
            return pageView
        }
        
        for (index, pageView) in pageViews.enumerated() {
            pageScrollView.addSubview(pageView)
            pageView.snp.makeConstraints { make in
                if index == 0 {
                    make.leading.equalTo(pageScrollView.contentLayoutGuide)
                } else {
                    make.leading.equalTo(pageViews[index - 1].snp.trailing)
                }
                make.top.bottom.equalTo(pageScrollView.contentLayoutGuide)
                make.width.height.equalToSuperview()
                if index == pageViews.count - 1 {
                    make.trailing.equalTo(pageScrollView.contentLayoutGuide)
                }
            }
        }
    }
}
