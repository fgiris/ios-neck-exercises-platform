//
//  ExerciseTableViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 5.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit
import UserNotifications

class ExerciseTableViewController: UITableViewController {

    var mFirebaseDBHelper : FirebaseDBHelper!
    var exercises = [FbExercise]()
    var finishedExercises = Array(repeating: false, count: 18)
    
    @IBOutlet weak var logoutBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mFirebaseDBHelper = FirebaseDBHelper()
        mFirebaseDBHelper.fb_schedule_user_alarms()
        if ControllerFunctionsHelper.isLanguageEnglish(){
            loadEnglishData()
            logoutBarButton.title = "Logout"
            self.navigationItem.title = "My Exercises"
            self.tabBarController?.tabBar.items?[0].title = "Exercises"
            self.tabBarController?.tabBar.items?[1].title = "Statistics"
            self.tabBarController?.tabBar.items?[2].title = "Settings"
        }
        else{
            loadData()
        }
        
        
        NetworkHelper.syncMediaFiles(viewController: self)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func loadData()
    {
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
        
        exercises+=[e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18]
        
    }
    
    func loadEnglishData()
    {
        let e1 = FbExercise(eid: "1", name: "Starting Breathing Exercise", exp: "Open your feet in your shoulder width, take a deep breath from your nose, draw your circles with arms and rise your toes, we blow our mouths out, down the arms and return to our starting position. Repeat this movement 3 times.", photo_link: "https://drive.google.com/uc?export=download&id=1x9jtrG94wXtk9RHbXF3DlcRGa9eEBcgB", rep: 3, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1AWCHIsdt3MDWmMJcS096dVMJEV5WDDAL", duration: 20)
        
        let e2 = FbExercise(eid: "2", name: "Breathing Exercise", exp: "Place one hand in your chest and your other hand in your stomach. We take a deep breath and blow our belly and slowly breathe out of our mouths. Repeat this movement 3 times.", photo_link: "https://drive.google.com/uc?export=download&id=11S6l1Cb0VIrqXq98YOXi6z8U5xM6j3av", rep: 3, set: 1, rest: 6, video_link: "https://drive.google.com/uc?export=download&id=1ry0x-7Pockg8exD8zapDw9O8hNp7dtaL", duration: 25)
        
        let e3 = FbExercise(eid: "3", name: "Shoulder Opening Exercise", exp: "As the arms are on the side of the body, we breathe and open arms so that the palms look at us, and we breathe and return to the starting position. Repeat this movement 3 times.", photo_link: "https://drive.google.com/uc?export=download&id=1HwPd_z3BlwPhWRE2qOwg35nBaMPN-xYK", rep: 3, set: 1, rest: 1, video_link: "https://drive.google.com/uc?export=download&id=1G1BzpSEsRfRT3WD7QBZ0JhjHrD8RKAue", duration: 20)
        
        let e4 = FbExercise(eid: "4", name: "Correct Posture Scheme", exp: "This video is very important because it is a diagram showing the correct stance during the exercise and during the day. General posture head in the front, shoulders round, back hung, increased lumbar lordosis. It is very important that all exercises are performed in the right position. The first image on the video is an example of bad stance, how about fixing it together? Find the middle point for the pelvis, the abdominal muscles in the muscle, the chest cage in the front, the back of the chin and pull the shoulders out. You must make sure that you are doing the exercises right! You must protect your correct posture during the day.", photo_link: "https://drive.google.com/uc?export=download&id=12AD5h3PPwPQY13xE_XcKYwtSJZDSkz-V", rep: 1, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1aL5tsHMbdeqeaKgVIhPIkNuQ28AMnvWc", duration: 10)
        
        let e5 = FbExercise(eid: "5", name: "Pectoral Stretch Exercise", exp: "Place the wall of your elbow twisted arm, take your opposite foot forward, make sure you are in the right position, protect your rib cage, give your body weight forward and turn slightly to the other side with your spine and wait here until you are 10 point and go back to your starting position. Repeat this exercise 3 times and go to the other side.", photo_link: "https://drive.google.com/uc?export=download&id=1vRr_WoQusq7zLymIPM3KaE5IJTlHgyJO", rep: 3, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1TcabwxPJIfgwndRVBN6FOKkny4YlIhdi", duration: 180)
        
        let e6 = FbExercise(eid: "6", name: "Strengthening Exercises of Deep Neck Muscles", exp: "Place a small soft ball behind your head, pull back your chin and release. Repeat this movement 10 times.", photo_link: "https://drive.google.com/uc?export=download&id=1h8F7eDQVWVoSWHBhpE-mPo924QhHzhm5", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1Y0ByxtFWcX1pLv5DsxDX6eNmwAHSuoc-", duration: 90)
        
        let e7 = FbExercise(eid: "7", name: "Strengthening Exercises of Deep Neck Muscles", exp: "In the right posture, feel all your cervical vertebrae one by one as if there is a book on your head and pull your chin back, count up to 3 and release. Repeat this movement 10 times.", photo_link: "https://drive.google.com/uc?export=download&id=1bqzygwqKFUi-LFC79_4vGAZ6W1RyiJtc", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1_tDC06QdHd5ZGcFK-IXEtyzyzemyHzPY", duration: 90)
        
        let e8 = FbExercise(eid: "8", name: "Neck Side Bending Exercise", exp: "In the right posture, pull your chin back by feeling all your cervical vertebrae one by one, keep this position and come to the middle point where the knee is twisted to the side, and to the twisted middle point on the other side. Repeat this movement 10 times.", photo_link: "https://drive.google.com/uc?export=download&id=16HRXdQIXW13epSeVM_2iiDgny5Grt45s", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1X7F2xNx0vRwMzHjxwJ2Hhr004yxfqTSv", duration: 90)
        
        let e9 = FbExercise(eid: "9", name: "Neck Rotation Exercise", exp: "In the right posture, pull your chin back by feeling all your cervical vertebrae one by one, keep this position and turn your sideways sideways to the middle point, turn the other side to the middle point. Repeat this movement 10 times.", photo_link: "https://drive.google.com/uc?export=download&id=1BCm2kHhNrdmB93ziYxohCMIiMMhiM3X7", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1odWPaDooOLDp3IbZWkl-Z_SIurONjXMb", duration: 80)
        
        let e10 = FbExercise(eid: "10", name: "Shoulder Lifting Exercise", exp: "In the right posture, turn your arms outward by opening your shoulders and lift your shoulders up to 3 and count down. Repeat this movement 10 times.", photo_link: "https://drive.google.com/uc?export=download&id=16NkOep873P8OH-9W84AJS8ULUIZcjObU", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1ITzZTN0YHXxlWVbsfFGc3zZWmrFzgh3t", duration: 80)
        
        let e11 = FbExercise(eid: "11", name: "Shoulder Compression Exercise", exp: "In the right posture, join your hands at the back, as if you had a ball in the middle of your shovel bones, we close the shovel bones to each other and count to 3. Repeat this movement 10 times.", photo_link: "https://drive.google.com/uc?export=download&id=1BmtgYKWEt0l5_Z-8M3BXUxzwFLKKuzcb", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1Z-KJ9JilS6M7Oo9-C5PpOSwbgjQXzpLd", duration: 80)
        
        let e12 = FbExercise(eid: "12", name: "Shoulder Compression Exercise", exp: "In the right posture, put your hands behind your head, pull your elbows backwards and try to bring your shovel bones closer together, count to 3 and release. Repeat this movement 10 times.", photo_link: "https://drive.google.com/uc?export=download&id=1jb7MW-At63neZYiNDRtC4hLo6cpH9Yh-", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1-hb-mPcf2TP9qd1Kk7eGdAI3jr6XeO53", duration: 60)
        
        let e13 = FbExercise(eid: "13", name: "Shoulder Forward-Back Exercise", exp: "In the right posture, open your arms shoulder width, as if holding a ball in your hand, stretch your shoulder bones up to where you can reach forward and pull your shoulder bones backwards to the point where you can pull them down. Repeat this movement 10 times.", photo_link: "https://drive.google.com/uc?export=download&id=1XN45JKZWRZf0D2RumoR6rONKUyra_efT", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1HAojeTc_BHzFv-r2lgnz5X9P9YBHQ1de", duration: 70)
        
        let e14 = FbExercise(eid: "14", name: "Back Mobility Exercise", exp: "While sitting on a chair, put your hands behind your head in the correct posture, keep the distance between the elbows and go back up to where you can go back and go back to the starting position. Repeat this movement 3 times.", photo_link: "https://drive.google.com/uc?export=download&id=1GpecvnTQxGyXPMKaCNOr6se1bmQB7sVM", rep: 3, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1CBMflXPHElhv7Z2aIORe57uRzO4Tq-JY", duration: 60)
        
        let e15 = FbExercise(eid: "15", name: "Body-Bending Exercise", exp: "Standing or sitting in the right posture, open your shoulders, breathe the body to the side and breathe on the other side. Repeat this movement 10 times.", photo_link: "https://drive.google.com/uc?export=download&id=1Ec1Xa9RgkGlK86W0tbEyAN240qJQ1e5r", rep: 10, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1pyne66OZyiiWVTY0MBiZ7tQyzJuXcNE3", duration: 60)
        
        let e16 = FbExercise(eid: "16", name: "Body-Turning Exercise", exp: "While sitting on the chair, in the right posture while hold one hand on your back support, your other hand on your back support, turn back to where you can turn your vertebrae back to the back support, count to 3 and return to your starting position. Repeat this movement 3 times and move to the other side.", photo_link: "https://drive.google.com/uc?export=download&id=1RzK4fdR-mKb9OEBKcbRux8Ts8QSEUZBS", rep: 3, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1xN2f2j8cAPbSeMC6rg3FAyeMvxDxmito", duration: 60)
        
        let e17 = FbExercise(eid: "17", name: "Breathing Exercise", exp: "We start from the position where we are most comfortable when we sit on the chair, we breathe, we step forward to the correct position and we breathe back to our starting position. Repeat this movement 3 times.", photo_link: "https://drive.google.com/uc?export=download&id=1-tvJwQQVUmIrgUL5SrlWLp6IQo2EUJdT", rep: 3, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1MmwY0b57ZfwHpoaebMiIyMu2iLuxzEkB", duration: 30)
        
        let e18 = FbExercise(eid: "18", name: "Front Bending Exercise", exp: "In the right posture, bend forward with all your spines feeling one by one and slowly return to your starting position, feeling all your spines one by one. You can end this exercise by repeating this movement 3 times.", photo_link: "https://drive.google.com/uc?export=download&id=1JBYIJ27K5wydQ0kr8K0A3O2Zn1TegEkr", rep: 3, set: 1, rest: 5, video_link: "https://drive.google.com/uc?export=download&id=1x0sxfB16h46K5XKwLx33aDk8bbTOs4Gt", duration: 60)
        
        exercises+=[e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.EXERCISE_TABLE_VIEW_CELL, for: indexPath) as? ExerciseTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ExerciseTableViewCell.")
        }

        
        let exercise = exercises[indexPath.row]
        cell.mExerciseImage.image = UIImage(named: exercise.eid!)
        cell.mExerciseName.text = exercise.name
        cell.mSetLabel.text = String((exercise.set as! Int))
        cell.mRepLabel.text = String(exercise.rep as! Int)
        cell.mDurationLabel.text = String(exercise.duration as! Int)+" sn"
        cell.doneImage.isHidden = true
        if ControllerFunctionsHelper.isLanguageEnglish(){
            cell.mSetLabelStaticText.text = "Set:"
            cell.mRepLabelStaticText.text = "Repeat:"
            cell.mDurationLabel.text = String(exercise.duration as! Int)+" s"
        }
        //cell.mExerciseName.text = "Test"
        //mFirebaseDBHelper.fb_load_exercises(cell: cell, indexPath: indexPath, viewController: self)
        mFirebaseDBHelper.fb_check_exercise_completed_today(viewController: self)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    @IBAction func logout(_ sender: UIBarButtonItem) {
        mFirebaseDBHelper.fb_attempt_loguot(viewController: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let exerciseDetailViewController = segue.destination as? ExerciseDetailViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedExerciseCell = sender as? ExerciseTableViewCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedExerciseCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedExercise = exercises[indexPath.row]
        exerciseDetailViewController.exercise = selectedExercise
        exerciseDetailViewController.isFinished = finishedExercises[indexPath.row]
        
    }
    

}
