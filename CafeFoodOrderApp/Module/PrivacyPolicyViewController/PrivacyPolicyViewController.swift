//
//  PrivacyPolicyViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 06/11/24.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var textArea: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadPrivacyPolicy()
        
    }
    func setup() {
        toolBarView.setup(title: "Privacy Policy")
    }
    func loadPrivacyPolicy() {
        // Teks kebijakan privasi
        let privacyPolicy = """
            Kebijakan Privasi untuk Cafe Order Food App (COFA)
            
            Tanggal Berlaku: 21 November 2024
            Terakhir Diperbarui: 21 November 2024
            
            Terima kasih telah menggunakan Cafe Order Food App (COFA). Privasi Anda sangat penting bagi kami, dan kami berkomitmen untuk melindungi data pribadi Anda. Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, membagikan, dan melindungi data Anda ketika menggunakan aplikasi kami. Harap baca Kebijakan ini dengan saksama.
            
            **1. Informasi yang Kami Kumpulkan**
            Kami dapat mengumpulkan jenis informasi berikut:
            
            **1.1 Informasi yang Anda Berikan**
            
            Data Pribadi: Nama, alamat email, nomor telepon, dan alamat pengiriman yang Anda masukkan saat membuat akun atau memesan.
            Informasi Pembayaran: Data pembayaran Anda diproses oleh pihak ketiga (seperti penyedia layanan pembayaran) dan tidak disimpan di server kami.
            Umpan Balik: Informasi yang Anda berikan saat menghubungi kami untuk dukungan atau memberikan umpan balik.
            
            **1.2 Informasi yang Dikumpulkan Secara Otomatis**
            
            Informasi Perangkat: Jenis perangkat, sistem operasi, dan pengenal unik perangkat.
            Informasi Penggunaan: Data tentang interaksi Anda dengan aplikasi, seperti halaman yang diakses dan waktu yang dihabiskan.
            Lokasi: Lokasi Anda untuk keperluan pengiriman, sesuai dengan pengaturan perangkat Anda.
            
            **2. Bagaimana Kami Menggunakan Informasi Anda**
            Informasi Anda digunakan untuk:
            
            Memproses Pesanan Anda: Memastikan pesanan dan pengiriman Anda berjalan lancar.
            Meningkatkan Layanan Kami: Menganalisis data untuk meningkatkan pengalaman pengguna.
            Komunikasi: Mengirimkan pembaruan, konfirmasi, dan penawaran promosi (jika Anda menyetujuinya).
            Keamanan: Melindungi aplikasi dari aktivitas penipuan.
            
            **3. Bagaimana Kami Membagikan Informasi Anda**
            Kami tidak menjual data Anda kepada pihak ketiga. Namun, kami dapat membagikan data Anda dalam situasi berikut:
            
            Penyedia Layanan: Dengan mitra seperti pengolah pembayaran atau layanan pengiriman.
            Kepatuhan Hukum: Jika diwajibkan oleh hukum atau untuk melindungi hak kami dan pengguna.
            Transfer Bisnis: Dalam hal merger atau akuisisi, data Anda dapat dialihkan ke entitas baru.
            
            **4. Hak Anda**
            Anda memiliki hak-hak berikut terkait data pribadi Anda:
            
            Akses dan Perbaikan: Anda dapat mengakses atau memperbarui informasi akun Anda melalui aplikasi.
            Penghapusan: Anda dapat meminta kami menghapus akun dan data Anda dengan menghubungi kami.
            Penolakan Promosi: Anda dapat menolak menerima komunikasi promosi dengan memperbarui preferensi di aplikasi.
            Untuk melaksanakan hak Anda, hubungi kami di support@cofaapp.com.
            
            **5. Keamanan Informasi**
            Kami menggunakan langkah-langkah teknis dan organisasi yang wajar untuk melindungi data Anda. Namun, tidak ada sistem yang sepenuhnya aman. Gunakan aplikasi kami dengan bijak.
            
            **6. Perubahan Kebijakan Privasi**
            Kami dapat memperbarui Kebijakan Privasi ini dari waktu ke waktu. Perubahan signifikan akan diinformasikan melalui aplikasi atau email. Harap periksa Kebijakan ini secara berkala untuk pembaruan.
            
            **7. Hubungi Kami**
            Jika Anda memiliki pertanyaan atau kekhawatiran tentang Kebijakan Privasi ini, silakan hubungi kami di:
            
            **Cafe Order Food App (COFA)**
            Email: support@cofaapp.com
            Telepon: +6281808370321
            Dengan menggunakan COFA, Anda menyetujui Kebijakan Privasi ini. Terima kasih atas kepercayaan Anda pada layanan kami!
        """
        
        let attributedText = NSMutableAttributedString(string: privacyPolicy)
        
        let boldRanges = [
                "Kebijakan Privasi untuk Cafe Order Food App (COFA)",
                "Informasi yang Kami Kumpulkan",
                "1. Informasi yang Anda Berikan",
                "2. Informasi yang Dikumpulkan Secara Otomatis"
            ]

        
        let boldFont = UIFont.boldSystemFont(ofSize: 16)
        let regularFont = UIFont.systemFont(ofSize: 14)
        
        attributedText.addAttribute(.font, value: regularFont, range: NSRange(location: 0, length: attributedText.length))
        
        for boldText in boldRanges {
            if let range = privacyPolicy.range(of: boldText) {
                let nsRange = NSRange(range, in: privacyPolicy)
                attributedText.addAttribute(.font, value: boldFont, range: nsRange)
            }
        }
        textArea.attributedText = attributedText
        textArea.isEditable = false
    }
}
