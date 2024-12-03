//
//  ColorCardsViewController.swift
//  ColorCards
//
//  Created by Suraj Bhatt on 03/12/24.
//

import UIKit
import Combine
import ToastViewSwift
import Reachability

class ColorCardsViewController: UIViewController {
    
    @IBOutlet weak var generateColorBtn: UIButton!
    @IBOutlet weak var colorCardCollectionView: UICollectionView!
    @IBOutlet weak var uploadBtn: UIButton!
    private var aColorCardsViewModel = ColorCardsViewModel()
    private var desposeBag:Set<AnyCancellable> = []
    private var colorCodesArray:[ColorHex]? = []
    private var isFirstTime:Bool? = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitSetUp()
        self.setCollectionView()
        self.setUpBinding()
        self.aColorCardsViewModel.retrieveColorCodeData()
    }
    
    // MARK: SetUp UI
    func setInitSetUp(){
        [self.generateColorBtn,self.uploadBtn].forEach { btn in
            btn?.layer.cornerRadius = 10
        }
        NotificationCenter.default.addObserver(self, selector: #selector(handleNetworkChange(_:)), name: NetworkManager.networkStatusChangedNotification, object: nil)
    }
    
    func setCollectionView(){
        let nib = UINib(nibName: Constant.CellIdentifier.identifier, bundle: nil)
        self.colorCardCollectionView.register(nib, forCellWithReuseIdentifier: Constant.CellIdentifier.identifier)
        self.colorCardCollectionView.delegate = self
        self.colorCardCollectionView.dataSource = self
    }
    
    func setUpBinding(){
        self.aColorCardsViewModel.$colorCodesArray.receive(on:DispatchQueue.main).sink { data in
            self.setGenerateCodeBtnState(isInteractive: true)
            if data != nil {
                self.colorCodesArray = data
                DispatchQueue.main.async {
                    self.colorCardCollectionView.reloadData()
                }
            }
        }.store(in: &desposeBag)
        
        self.aColorCardsViewModel.$error.receive(on:DispatchQueue.main).sink { _ in
            self.setGenerateCodeBtnState(isInteractive: true)
        }.store(in: &desposeBag)
    }
    
    func setGenerateCodeBtnState(isInteractive:Bool?){
        self.generateColorBtn.isUserInteractionEnabled = isInteractive ?? true
    }
    
    // MARK: Button Action
    
    @IBAction func generateColorBtnAction(_ sender: UIButton) {
        if let hexCode = self.generateRandomHexColor(){
            self.setGenerateCodeBtnState(isInteractive: false)
            self.aColorCardsViewModel.saveColorCodeToDataBase(hexCode: hexCode)
        }
    }
    
    @objc private func handleNetworkChange(_ notification: Notification) {
        guard let isConnected = notification.object as? Bool else { return }
        if isConnected && !(self.isFirstTime ?? false) {
            self.internetConnectivityPopUp(message:self.colorCodesArray?.count ?? 0 > 1 ? Constant.Alert.syncingStart : Constant.Alert.internetBack)
            self.aColorCardsViewModel.retrieveColorCodeData()
        } else if !isConnected && !(self.isFirstTime ?? false)  {
            self.internetConnectivityPopUp(message:Constant.Alert.internetGone)
        }else if !isConnected && (self.isFirstTime ?? false)  {
            self.internetConnectivityPopUp(message:Constant.Alert.noInternet)
        }
        self.isFirstTime = false
    }
}

// MARK: Collection Datasource
extension ColorCardsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.colorCodesArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.identifier, for: indexPath) as? ColorCardsCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(hexColor: self.colorCodesArray?[indexPath.item])
        return cell
    }
}

// MARK: Collection Delegate
extension ColorCardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

