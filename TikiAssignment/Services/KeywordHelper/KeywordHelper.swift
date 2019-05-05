//
//  KeywordHelper.swift
//  TikiAssignment
//
//  Created by DUYLINH on 5/4/19.
//  Copyright © 2019 DUYLINH. All rights reserved.
//

import UIKit

final class KeywordHelper {
    
    class func calculateMinLengthOfKeyword(with keyword: String) -> CGFloat {
        /*
         Yêu cầu:
           - Keyword hiển thị với font system kích cở là 14.
           - Keyword hiển thị align center.
           - Nếu keyword rỗng hoặc chỉ có khoảng trắng hoặc xuống dòng thì ẩn
           - Nếu keyword chỉ có một từ thì hiển thị 1 dòng.
           - Keyword có 2 từ trở lên thì ta cần hiển thi 2 dòng sao cho khoảng cách là ngắn nhất và các từ không bị đứt cụt (không bị truncate).
         
         Thuật toán xử lý:
         - Keyword hiển thị với font system kích cở là 14.
         - Keyword hiển thị align center.
         ==> Xử lý trong cấu hình UI trên storyboard. Đồng thời các xử lý bên dưới cũng sẽ tính toán trên font 14.
         
         - Nếu keyword rỗng hoặc chỉ có khoảng trắng thì ẩn
         ==> Đã xử lý trường hợp này lúc parse dữ liệu lấy từ api.
         
         Bước 1: Ta tách một chuỗi thành nhiều từ đơn lẻ.
            + Nếu keyword chỉ có một từ thì hiển thị 1 dòng.
            --> return minlength
            + Nếu keyword có 2 từ trở lên
         
            Bước 1: Ta tách một chuỗi thành nhiều từ đơn lẻ.
            Bước 2: Tính toán độ dài từng từ.
             (Một từ ta định nghĩa ở đây sẽ bao gồm từ đó cộng với một ký tự khoảng trắng)
            Bước 3: Tính độ dài tổng tất cả các từ cộng lại. (ở đây mỗi từ sẽ là gồm từ đó + khoảng trắng)
            Bước 4: Ta lần lượt cộng chiều dài các từ theo 2 chiều (thuận và ngược) với điều kiện là giá trị tổng cộng dồn đó nhỏ hơn lengthOfAString/2.
                Đồng thời ta cũng tạo một keyword mới từ keyword cũ.
                (Keyword mới sẽ giúp loại bỏ các ký tự thừa như với nhiều khoảng trắng liên tiếp...)
            Bước 5: Trả về kết quả cuối cùng ta nhận được sẽ là độ dài ngắn nhất như yêu cầu.
         */
        var wordArray = keyword.splitWords
        guard wordArray.count > 1 else{
            return wordArray[0].widthOfTextWithFont14()
        }
        
        let lengthOfASpaceChar:CGFloat = " ".widthOfTextWithFont14()
        let lengthOfAString:CGFloat = keyword.trim().widthOfTextWithFont14() + CGFloat((wordArray.count - 1))*lengthOfASpaceChar
        
        var newKeyword:String = wordArray[0]
        
        //theo chiều thuận kim đồng hồ
        var lengthOfHalvesClockwise:CGFloat = wordArray[0].widthOfTextWithFont14()
        //theo chiều ngược kim đồng hồ
        var lengthOfHalvesAnticlockwise:CGFloat = wordArray[(wordArray.count - 1)].widthOfTextWithFont14()
        
        for i in 1...(wordArray.count - 1){
            if lengthOfHalvesClockwise < lengthOfAString/2 {
                lengthOfHalvesClockwise += (wordArray[i].widthOfTextWithFont14() + lengthOfASpaceChar)
//                print("==============\nlengthOfHalvesClockwise = \(lengthOfHalvesClockwise)   \(wordArray[i])  - \((wordArray[i].widthOfTextWithFont14() + lengthOfASpaceChar ))\n==============")
            }
            
            if lengthOfHalvesAnticlockwise < lengthOfAString/2 {
                lengthOfHalvesAnticlockwise += (wordArray[(wordArray.count - 1) - i].widthOfTextWithFont14() + lengthOfASpaceChar)
//                print("==============\nlengthOfHalvesAnticlockwise = \(lengthOfHalvesAnticlockwise) \(wordArray[(wordArray.count - 1) - i])  - \((wordArray[(wordArray.count - 1) - i].widthOfTextWithFont14() + lengthOfASpaceChar))\n==============")
            }
            newKeyword.append(" \(wordArray[i])")
        }
        return min(lengthOfHalvesClockwise, lengthOfHalvesAnticlockwise)
    }
    
    class func createNewKeyword(with keyword: String) -> String {
        var wordArray = keyword.splitWords
        guard wordArray.count > 1 else{
            return keyword
        }
        var newKeyword:String = wordArray[0]
        for i in 1...(wordArray.count - 1){
            newKeyword.append(" \(wordArray[i])")
        }
        return newKeyword
    }
}


