//
//  NetworkHelper.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 11.07.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import Foundation
//
//  NetworkHelper.swift
//  diabetex
//
//  Created by Muhendis on 13.06.2018.
//  Copyright © 2018 Diabetex. All rights reserved.
//

import Foundation
import SystemConfiguration
import NVActivityIndicatorView
import Alamofire

public class NetworkHelper {
    
    static var numberOfVideoToDownload=0
    static var hasDownloadError = false
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
    static func syncMediaFiles(viewController:UIViewController){
        
        let e1 = FbExercise(eid: "1", name: "Başlangıç Nefes Egzersizi", exp: "Ayaklarınızı omuz genişliğinizde açın, burnumuzdan derin bir nefes alarak kollarımızla daire çizerek ayak parmak uçlarımıza yükseliyoruz, ağzımızdan üfleyerek nefes vererek kollarımızı aşağıya indiriyoruz ve başlangıç pozisyonumuza geri dönüyoruz. Bu hareketi 3 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=1x9jtrG94wXtk9RHbXF3DlcRGa9eEBcgB", rep: 3, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1AWCHIsdt3MDWmMJcS096dVMJEV5WDDAL", duration: 20)
        
        let e2 = FbExercise(eid: "2", name: "Nefes Egzersizi", exp: "Bir elinizi göğüs kafesinize diğer elinizi karnınıza yerleştirin. Burnumuzdan derin bir nefes alarak karnımızı şişiriyoruz ve yavaşça ağzımızdan üfleyerek nefes veriyoruz. Bu hareketi 3 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=11S6l1Cb0VIrqXq98YOXi6z8U5xM6j3av", rep: 3, set: 1, rest: 6, video_link: "https://drive.google.com/uc?export=download&id=1ry0x-7Pockg8exD8zapDw9O8hNp7dtaL", duration: 25)
        
        let e3 = FbExercise(eid: "3", name: "Omuz Açma Egzersizi", exp: "Kollar gövde yanındayken nefes alarak kollarınızı avuç içleri bize bakacak şekilde açıyoruz ve nefes vererek başlangıç pozisyonuna geri dönüyoruz. Bu hareketi 3 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=1HwPd_z3BlwPhWRE2qOwg35nBaMPN-xYK", rep: 3, set: 1, rest: 1, video_link: "https://drive.google.com/uc?export=download&id=1G1BzpSEsRfRT3WD7QBZ0JhjHrD8RKAue", duration: 20)
        
        let e4 = FbExercise(eid: "4", name: "Doğru Duruş Şeması", exp: "Bu video, egzersiz süresince ve gün içerisindeki doğru duruşu gösteren bir şema olmasından dolayı çok önemlidir. Genel duruş şekli baş önde, omuzlar yuvarlak, sırtta kamburluk, artmış bel çukuru şeklindedir. Bütün egzersizlerin doğru duruş pozisyonunda yapılması çok önemlidir. Videodaki ilk görüntü kötü duruşa bir örnek,  bunu birlikte düzeltmeye ne dersin? Kalçan için orta noktayı bul, karın kaslarını kas, göğüs kafesi önde, çeneni geriye doğru çek ve omuzlarını dışarı doğru çevir. Egzersizleri doğru duruşta yaptığınızdan emin olmalısınız! Gün içerisinde doğru duruşunuzu korumalısınız.", photo_link: "https://drive.google.com/uc?export=download&id=12AD5h3PPwPQY13xE_XcKYwtSJZDSkz-V", rep: 1, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1aL5tsHMbdeqeaKgVIhPIkNuQ28AMnvWc", duration: 10)
        
        let e5 = FbExercise(eid: "5", name: "Pektoral Germe Egzersizi", exp: "Kolunuzu dirseğiniz bükük bir duvar köşesine yerleştirin, karşı taraf ayağınızı bir adım öne alın, doğru duruş pozisyonunda olduğunuzdan emin olun, göğüs kafesi bağlantınızı koruyun, vücut ağırlığınızı öne doğru verin ve omurganızla diğer tarafa hafifçe dönün ve burada bekleyin 10’a kadar sayın, omurganızla orta noktaya gelin ve başlangıç pozisyonuna geri dönün. Bu egzersizi 3 kere tekrarlayınız ve diğer tarafa geçiniz.", photo_link: "https://drive.google.com/uc?export=download&id=1vRr_WoQusq7zLymIPM3KaE5IJTlHgyJO", rep: 3, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1TcabwxPJIfgwndRVBN6FOKkny4YlIhdi", duration: 180)
        
        let e6 = FbExercise(eid: "6", name: "Derin Boyun Kaslarını Güçlendirme Egzersizi", exp: "Başınızın arkasına küçük yumuşak bir top yerleştirin çenenizi geriye doğru çekin ve bırakın. Bu hareketi 10 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=1h8F7eDQVWVoSWHBhpE-mPo924QhHzhm5", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1Y0ByxtFWcX1pLv5DsxDX6eNmwAHSuoc-", duration: 90)
        
        let e7 = FbExercise(eid: "7", name: "Derin Boyun Kaslarını Güçlendirme Egzersizi", exp: "Doğru duruş pozisyonunda bütün boyun omurlarınızı tek tek hissederek başınızın üzerinde bir kitap varmış gibi çenenizi geriye doğru çekin 3’e kadar sayın ve bırakın. Bu hareketi 10 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=1bqzygwqKFUi-LFC79_4vGAZ6W1RyiJtc", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1_tDC06QdHd5ZGcFK-IXEtyzyzemyHzPY", duration: 90)
        
        let e8 = FbExercise(eid: "8", name: "Boyun Yana Bükme Egzersizi", exp: "Doğru duruş pozisyonunda bütün boyun omurlarınızı tek tek hissederek çenenizi geriye doğru çekin, bu pozisyonu koruyarak boynunuzu yana bükün orta noktaya gelin, diğer yan tarafa bükün orta noktaya gelin. Bu hareketi 10 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=16HRXdQIXW13epSeVM_2iiDgny5Grt45s", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1X7F2xNx0vRwMzHjxwJ2Hhr004yxfqTSv", duration: 90)
        
        let e9 = FbExercise(eid: "9", name: "Boyun Yana Dönme Egzersizi", exp: "Doğru duruş pozisyonunda bütün boyun omurlarınızı tek tek hissederek çenenizi geriye doğru çekin, bu pozisyonu koruyarak boynunuzu yana döndürün orta noktaya gelin, diğer yan tarafa döndürün orta noktaya gelin. Bu hareketi 10 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=1BCm2kHhNrdmB93ziYxohCMIiMMhiM3X7", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1odWPaDooOLDp3IbZWkl-Z_SIurONjXMb", duration: 80)
        
        let e10 = FbExercise(eid: "10", name: "Omuz Kaldırma Egzersizi", exp: "Doğru duruş pozisyonunda omuzlarınızı açarak kollarınızı dışarıya çevirin ve omuzlarınızı yukarıya kaldırın 3’e kadar sayın ve aşağıya indirin. Bu hareketi 10 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=16NkOep873P8OH-9W84AJS8ULUIZcjObU", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1ITzZTN0YHXxlWVbsfFGc3zZWmrFzgh3t", duration: 80)
        
        let e11 = FbExercise(eid: "11", name: "Omuz Sıkıştırma Egzersizi", exp: "Doğru duruş pozisyonunda ellerinizi arkada birleştirin, kürek kemiklerinizin ortasında bir top varmış gibi kürek kemiklerini birbirine yaklaştırıyoruz 3’e kadar sayıyoruz ve bırakıyoruz. Bu hareketi 10 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=1BmtgYKWEt0l5_Z-8M3BXUxzwFLKKuzcb", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1Z-KJ9JilS6M7Oo9-C5PpOSwbgjQXzpLd", duration: 80)
        
        let e12 = FbExercise(eid: "12", name: "Omuz Sıkıştırma Egzersizi", exp: "Doğru duruş pozisyonunda ellerinizi başınızın arkasında birleştirin, dirseklerinizi geriye doğru çekerek kürek kemiklerinizi birbirine yaklaştırmaya çalışın, 3’e kadar sayın ve bırakın. Bu hareketi 10 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=1jb7MW-At63neZYiNDRtC4hLo6cpH9Yh-", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1-hb-mPcf2TP9qd1Kk7eGdAI3jr6XeO53", duration: 60)
        
        let e13 = FbExercise(eid: "13", name: "Omuz İleri-Geri Egzersizi", exp: "Doğru duruş pozisyonunda kollarınızı omuz genişliğinde açın, elinizde bir top tutuyormuş gibi kürek kemiklerinizle öne uzanabildiğiniz yere kadar uzanın ve kürek kemiklerinizi geriye aşağıya doğru çekebildiğiniz yere kadar çekin.  Bu hareketi 10 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=1XN45JKZWRZf0D2RumoR6rONKUyra_efT", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1HAojeTc_BHzFv-r2lgnz5X9P9YBHQ1de", duration: 70)
        
        let e14 = FbExercise(eid: "14", name: "Sırt Hareketlilik Egzersizi", exp: "Bir sandalyede otururken doğru duruş pozisyonunda ellerinizi başınızın arkasında birleştirin, dirsek arası mesafeyi koruyarak gövdenizle geriye doğru gidebildiğiniz yere kadar gidin ve başlangıç pozisyonuna geri dönün. Bu hareketi 3 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=1GpecvnTQxGyXPMKaCNOr6se1bmQB7sVM", rep: 3, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1CBMflXPHElhv7Z2aIORe57uRzO4Tq-JY", duration: 60)
        
        let e15 = FbExercise(eid: "15", name: "Gövde Yana Bükme Egzersizi", exp: "Ayakta veya oturarak doğru duruş pozisyonunda omuzlarınızı açın, nefes vererek gövdenizi yana bükün ve nefes vererek diğer yan tarafa bükün. Bu hareketi 10 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=1Ec1Xa9RgkGlK86W0tbEyAN240qJQ1e5r", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1pyne66OZyiiWVTY0MBiZ7tQyzJuXcNE3", duration: 60)
        
        let e16 = FbExercise(eid: "16", name: "Gövde Yana Dönme Egzersizi", exp: "Sandalyede otururken, doğru duruş pozisyonunda bir eliniz oturma desteğinde diğer eliniz sırt desteğinden tutarak, omurganızla sırt desteğine doğru dönebildiğiniz yere kadar dönmeye çalışıyoruz 3’e kadar sayıyoruz ve başlangıç pozisyonuna dönüyoruz. Bu hareketi 3 kere tekrarlayınız ve diğer tarafa geçiniz.", photo_link: "https://drive.google.com/uc?export=download&id=1RzK4fdR-mKb9OEBKcbRux8Ts8QSEUZBS", rep: 3, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1xN2f2j8cAPbSeMC6rg3FAyeMvxDxmito", duration: 60)
        
        let e17 = FbExercise(eid: "17", name: "Nefes Egzersizi", exp: "Sandalyede otururken en rahat olduğumuz pozisyondan başlıyoruz, nefes alarak adım adım doğru duruşa ilerliyoruz ve nefes vererek başlangıç pozisyonumuza geri dönüyoruz. Bu hareketi 3 kere tekrarlayınız.", photo_link: "https://drive.google.com/uc?export=download&id=1-tvJwQQVUmIrgUL5SrlWLp6IQo2EUJdT", rep: 3, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1MmwY0b57ZfwHpoaebMiIyMu2iLuxzEkB", duration: 30)
        
        let e18 = FbExercise(eid: "18", name: "Öne Eğilme Egzersizi", exp: "Doğru duruş pozisyonunda bütün omurlarınızı tek tek hissederek öne doğru eğilin ve yavaşça bütün omurlarınızı tek tek hissederek geriye başlangıç pozisyonuna geri dönün. Bu hareketi 3 kere tekrarlayarak egzersizi sonlandırabilirsiniz.", photo_link: "https://drive.google.com/uc?export=download&id=1JBYIJ27K5wydQ0kr8K0A3O2Zn1TegEkr", rep: 3, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1x0sxfB16h46K5XKwLx33aDk8bbTOs4Gt", duration: 60)
        var exercises = [FbExercise]()
        var exerciseVideoLinksToDownload:[String]
        var exerciseVideoFileNamesToDownload:[String]
        
        exercises += [e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18]
        var eList=[[String]]()
        
        for e in exercises{
            if !isFileExisting(fileName: e.eid!+".mp4", dir: "videos"){
                eList.append([e.eid!,e.video_link!])
            }
        }
        
        
        numberOfVideoToDownload = eList.count
        
        //let allMediaFilesToDownload = allImageFilesToDownload + allVideoFilesToDownload
        
        if numberOfVideoToDownload>0
        {
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                var title = "Veriler İndirilecek"
                var message = "Program verileri indirilecektir. Lütfen internete bağlı olduğunuzdan emin olunuz."
                if ControllerFunctionsHelper.isLanguageEnglish(){
                    title = "Media Download"
                    message = "Media files will be downloaded. Please ensure that you have internet connection."
                }
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: {action in
                    if !NetworkHelper.isConnectedToNetwork(){
                        if ControllerFunctionsHelper.isLanguageEnglish(){
                            ControllerFunctionsHelper.show_error(viewController: viewController, title: "Download Failed", info: "Please make sure that you have internet connection in order to download media files for exercises.")
                        }
                        else{
                            ControllerFunctionsHelper.show_error(viewController: viewController, title: "Program Verileri İndirilemedi", info: "Program verilerini indirmek için lütfen internete bağlı olduğunuzdan emin olup tekrar deneyiniz.")
                        }
                        
                    }
                    else{
                        var activityData = ActivityData(size: nil, message: "Lütfen ekranı kapatmadan bekleyiniz. Program verileri indiriliyor. Videoların indirilmesi zaman alabilir. ", messageFont: nil, type: nil, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.darkGray, textColor: UIColor.white)
                        
                        if ControllerFunctionsHelper.isLanguageEnglish(){
                            activityData = ActivityData(size: nil, message: "Media files for exercises are being downloaded. Please do not turn off the screen until download is finished. This process may take some time.", messageFont: nil, type: nil, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.darkGray, textColor: UIColor.white)
                            
                        }
                        
                        
                        for video in eList{
                            downloadVideoMov(urlString: video[1], fileName: video[0])
                        }
                        
                        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                    }}))
                
                topController.present(alert, animated: true)
            }
            
        }
    }
    
    static func getMediaDir() -> String{
        return NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first! + "/.mu_neck_exercises/"
    }
    
    
    static func getVideoFilePathForExercise(exercise:FbExercise) -> String{
        let videoFilePath = getMediaDir() + "videos/" + exercise.eid! + ".mp4";
        return videoFilePath
    }
    
    static func isFileExisting(fileName:String,dir:String) -> Bool{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path+"/.mu_neck_exercises/"+dir+"/")
        if let pathComponent = url.appendingPathComponent(fileName) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    // Be careful about extension (video files should have .mp4 type for this method)
    static func downloadVideoMov(urlString:String,fileName:String){
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let fileURL = documentsURL.appendingPathComponent(".mu_neck_exercises/videos/\(fileName).mp4")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 1000
        manager.session.configuration.timeoutIntervalForResource = 1000
        
        manager.download(urlString, to: destination).response { response in
            
            numberOfVideoToDownload -= 1
            
            if response.error == nil, let videoPath = response.destinationURL?.path {
                
            }
            else{
                print("there is an error while downloading video!!!")
                print(response.error)
                hasDownloadError = true
            }
            
            if (numberOfVideoToDownload < 1) && (!hasDownloadError)
            {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                if ControllerFunctionsHelper.isLanguageEnglish(){
                    ControllerFunctionsHelper.show_info(title: "Download Successful", info: "Media files are downloaded successfuly")
                }
                else{
                    ControllerFunctionsHelper.show_info(title: "İndirme Başarılı", info: "Program verileri başarı ile indirildi")
                }
                
            }
            else if (numberOfVideoToDownload < 1)
            {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                if ControllerFunctionsHelper.isLanguageEnglish(){
                    ControllerFunctionsHelper.show_info(title: "Download Failed", info: "There is an error while downloading the media files. Please make sure you have internet connection and restart the app.")
                }
                else{
                    ControllerFunctionsHelper.show_info(title: "İndirme Başarısız", info: "Program verileri indirilirken hata oluştu. Lütfen internete bağlı olduğunuzdan emin olup uygulamayı tekrar başlatınız.")
                }
                
            }
            
        }
    }
    
    
}
