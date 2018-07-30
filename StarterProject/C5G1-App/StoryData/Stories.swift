//
//  engish.swift
//  iOS
//
//  Created by Cluster 5 on 7/28/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation

class Stories {
    
    static func chinese_1() -> [PromptAndResponse] {
        return StoryBuilder()
            
            .createNew()
            .p("你好！ 今天能和你一起去购物很开心！你想买点什么呢？", "TODO")
            .cr("我想买些新衣服， 也可能买个新电脑", "TODO")
            .wr("我想卖掉我的狗因为她老了", "TODO")
            .wr("我什么都不想买。今天太热了", "TODO")
            
            .createNew()
            .p("好的！我们可以先去逛卖衣服的店， 然后去苹果店。你想买什么样的衣服呢？", "TODO")
            .cr("我想买些裤子，一件卫衣，还有一些袜子", "TODO")
            .wr("我想买一个水瓶，一个书包，和一zhi牙刷", "TODO")
            .wr("我想买点颜料，纸和铅笔", "TODO")
            
            .createNew()
            .p("听起来不错！ 店在这边，跟我走吧.", "TODO")
            
            .createNew()
            .p("你想试穿点什么吗?", "TODO")
            .cr("那个红色的裤子看着不错。你觉得它适合我吗", "TODO")
            .wr("我不是很喜欢蓝色的长袖体恤因为他们让我看起来病怏怏的", "TODO")
            .wr("绿色是我最喜欢的颜色", "TODO")
            
            .createNew()
            .p("我觉得它是合适的 你应该去试试", "TODO")
            
            .createNew()
            .p("怎么样？", "TODO")
            .cr("我觉得很合适， 看起来也不错， 红色和我的体恤很合适", "TODO")
            .wr("你今天很好看！我喜欢你的裤子", "TODO")
            .wr("我不明白这个店为什么一直这么冷", "TODO")
            
            .createNew()
            .p("太好了 我们现在去付钱吧", "TODO")
            
            .createNew()
            .p("您好 谢谢您光临本店 您感觉还不错嘛", "TODO")
            .cr("挺好的 没碰到什么问题 ", "TODO")
            .wr("我觉得我想再买些裤子", "TODO")
            .wr("我害怕在商场购物 我们能回家吗", "TODO")
            
            .createNew()
            .p("太好了 您是付现金还是刷卡", "TODO")
            .cr("我刷卡", "TODO")
            .wr("我会干苦力来还钱", "TODO")
            .wr("我觉得我不需要为我买的衣服付钱", "TODO")
            
            .createNew()
            .p("好的 总共180元", "TODO")
            
            .createNew()
            .p("都好了 祝您度过愉快的一天", "TODO")
            
            .createNew()
            .p("好了 我们去苹果店吧 你喜欢哪些产品", "TODO")
            .cr("我很喜欢当下虚拟现实里的创意 手机也做的越来越好了", "TODO")
            .wr("我觉得微波炉变得更快了 我可以更快的烤蛋糕", "TODO")
            .wr("我昨天买了个新手表 比我的旧手表好看多了", "TODO")
            
            .createNew()
            .p("我也是 你平时最常用什么科技产品", "TODO")
            .cr("我的手机 电视和我的笔记本电脑", "TODO")
            .wr("勺子 碗 和 叉子", "TODO")
            .wr("狗链 狗玩具和橡皮筋", "TODO")
            
            .createNew()
            .p("你是说你想要个新电脑来着 对吧 你现在的电脑有什么问题吗", "TODO")
            .cr("它开机不了 因为它太久了电池不行了", "TODO")
            .wr("它坏了因为我的狗吃了它", "TODO")
            .wr("它还挺好的所以我不需要一个新电脑", "TODO")
            
            .createNew()
            .p("好 我们应该问问工作人员 你就可以选个新电脑了 打扰一下", "TODO")
            
            .createNew()
            .p("您好 有什么可以帮助你的", "TODO")
            .cr("我想买个新电脑", "TODO")
            .wr("我想领养一条狗", "TODO")
            .wr("我想买个新电视", "TODO")
            
            .createNew()
            .p("好的 您想要个多大的电脑", "TODO")
            .cr("我想要最大的型号", "TODO")
            .wr("我想要它比我的手机小", "TODO")
            .wr("我想要它比我的电视大", "TODO")
            
            .createNew()
            .p("你希望他有什么功能", "TODO")
            .cr("希望它电池持续的久 是触屏的 还有个好的键盘", "TODO")
            .wr("一个好的颜色 摸起来软软的 和亮亮的屏幕", "TODO")
            .wr("长腿 角 很多 毛", "TODO")
            
            .createNew()
            .p("好的 我觉得这款很适合您 您可以去结账了", "TODO")
            
            .createNew()
            .p("您好 请问您是现金还是刷卡", "TODO")
            .cr("我付现金", "TODO")
            .wr("我付价钱", "TODO")
            .wr("我不会为了电脑付钱的", "TODO")
            
            .createNew()
            .p("你需要多少个100元和10元的纸币去副6670元呢", "TODO")
            .cr("67个100元纸币和7个10元纸币", "TODO")
            .wr("45个100元纸币和8个10元纸币", "TODO")
            .wr("124个100元纸币和5个10元纸币", "TODO")
            
            .createNew()
            .p("谢谢您光临本店", "TODO")
            .cr("谢谢您再见", "TODO")
            .wr("不用了 谢谢你", "TODO")
            .wr("请给我好吗", "TODO")
            
            .createNew()
            .p("", "TODO")
            .cr("", "TODO")
            .wr("", "TODO")
            .wr("", "TODO")
            
            .createNew()
            .p("", "TODO")
            .cr("", "TODO")
            .wr("", "TODO")
            .wr("", "TODO")
            
            .createNew()
            .p("", "TODO")
            .cr("", "TODO")
            .wr("", "TODO")
            .wr("", "TODO")
            
            .createNew()
            .p("", "TODO")
            .cr("", "TODO")
            .wr("", "TODO")
            .wr("", "TODO")
            
            .createNew()
            .p("", "TODO")
            .cr("", "TODO")
            .wr("", "TODO")
            .wr("", "TODO")
            
            .build()
    }
}

/* Example:
 .createNew()
 .p("", "TODO")
 .cr("", "TODO")
 .wr("", "TODO")
 .wr("", "TODO")
 */
