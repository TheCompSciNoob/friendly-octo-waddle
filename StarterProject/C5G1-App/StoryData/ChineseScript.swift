//
//  ChineseScript.swift
//  iOS
//
//  Created by Cluster 5 on 7/31/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

func chineseMall1() -> [PromptAndResponse] {
    return StoryBuilder()
        
        .createNew()
        .p("你好！ 今天能和你一起去购物很开心！你想买点什么呢？", "line1.wav", 5, 0, 0)
        .cr("我想买些新衣服， 也可能买个新电脑。", "line2a.wav")
        .wr("我想卖掉我的狗, 因为她老了。", "line2b.wav")
        .wr("我什么都不想买。今天太热了!", "line2c.wav")
        
        .createNew()
        .p("好的！我们可以先去逛卖衣服的店， 然后去苹果店。你想买什么样的衣服呢？", "line3.wav", 5, 0, 0)
        .cr("我想买些裤子，一件卫衣，还有一些袜子。", "line4a.wav")
        .wr("我想买一个水瓶，一个书包，和一支牙刷支。", "line4b.wav")
        .wr("我想买点颜料，纸, 和铅笔。", "line4c.wav")
        
        .createNew()
        .p("听起来不错！ 店在这边，跟我走吧。", "line5.wav", 5, 0, 0)
        
        .createNew()
        .p("你想试穿点什么吗?", "line6.wav", 5, 0, 0)
        .cr("那个红色的裤子看着不错。你觉得它适合我吗?", "line7a.wav")
        .wr("我不是很喜欢蓝色的长袖体恤, 因为他们让我看起来病怏怏的。", "line7b.wav")
        .wr("绿色是我最喜欢的颜色。", "line7c.wav")
        
        .createNew()
        .p("我觉得它是合适的。你应该去试试。", "line8.wav", 5, 0, 0)
        
        .createNew()
        .p("怎么样？", "line9.wav", 5, 0, 0)
        .cr("我觉得很合适， 看起来也不错， 红色和我的体恤很合适。", "line10a.wav")
        .wr("你今天很好看！我喜欢你的裤子。", "line10b.wav")
        .wr("我不明白这个店为什么一直这么冷。", "line10c.wav")
        
        .createNew()
        .p("太好了, 我们现在去付钱吧。", "line11.wav", 5, 0, 0)
        
        .createNew()
        .p("您好, 谢谢您光临本店。您感觉还不错嘛?", "line12.wav", 0, 5, 0)
        .cr("挺好的, 没碰到什么问题。", "line13a.wav")
        .wr("我觉得我想再买些裤子。", "line13b.wav")
        .wr("我害怕在商场购物。我们能回家吗?", "line13c.wav")
        
        .createNew()
        .p("太好了, 您是付现金还是刷卡?", "line14.wav", 0, 5, 0)
        .cr("我刷卡。", "line15a.wav")
        .wr("我会干苦力来还钱。", "line15b.wav")
        .wr("我觉得我不需要为我买的衣服付钱。", "line15c.wav")
        
        .createNew()
        .p("好的, 总共180元。都好了, 祝您度过愉快的一天。", "line16.wav", 0, 5, 0)
        
        .build()
}

func chineseMall2() -> [PromptAndResponse] {
    return StoryBuilder()
        
        .createNew()
        .p("好了, 我们去苹果店吧。你喜欢哪些产品?", "line18.wav", 5, 0, 0)
        .cr("我很喜欢当下虚拟现实里的创意。手机也做的越来越好了!", "line19a.wav")
        .wr("我觉得微波炉变得更快了。我可以更快的烤蛋糕。", "line19b.wav")
        .wr("我昨天买了个新手表, 比我的旧手表好看多了!", "line19c.wav")
        
        .createNew()
        .p("我也是。你平时最常用什么科技产品?", "line20.wav", 5, 0, 0)
        .cr("我的手机, 电视, 和我的笔记本电脑。", "line21a.wav")
        .wr("勺子, 碗, 和 叉子。", "line21b.wav")
        .wr("狗链, 狗玩具, 和橡皮筋。", "line21c.wav")
        
        .createNew()
        .p("你是说你想要个新电脑来着。 对吧, 你现在的电脑有什么问题吗?", "line22.wav", 5, 0, 0)
        .cr("它开机不了, 因为它太久了电池不行了。", "line23a.wav")
        .wr("它坏了, 因为我的狗吃了它。", "line23b.wav")
        .wr("它还挺好的, 所以我不需要一个新电脑。", "line23c.wav")
        
        .createNew()
        .p("好, 我们应该问问工作人员。你就可以选个新电脑了。打扰一下。", "line24.wav", 5, 0, 0)
        
        .createNew()
        .p("您好, 有什么可以帮助你的?", "line25.wav", 0, 5, 0)
        .cr("我想买个新电脑。", "line26a.wav")
        .wr("我想领养一条狗。", "line26b.wav")
        .wr("我想买个新电视。", "line26c.wav")
        
        .createNew()
        .p("好的, 您想要个多大的电脑?", "line27.wav", 0, 5, 0)
        .cr("我想要最大的型号。", "line28a.wav")
        .wr("我想要它比我的手机小。", "line28b.wav")
        .wr("我想要它比我的电视大。", "line28c.wav")
        
        .createNew()
        .p("你希望他有什么功能?", "line29.wav", 0, 5, 0)
        .cr("希望它电池持续的久, 是触屏的, 还有个好的键盘。", "line30a.wav")
        .wr("一个好的颜色, 摸起来软软的, 和亮亮的屏幕。", "line30b.wav")
        .wr("长腿, 角, 和很多毛。", "line30c.wav")
        
        .createNew()
        .p("好的, 我觉得这款很适合您。 您可以去结账了。", "line31.wav", 0, 5, 0)
        
        .createNew()
        .p("您好, 请问您是现金还是刷卡?", "line32.wav", 0, 5, 0)
        .cr("我付现金。", "line33a.wav")
        .wr("我付价钱。", "line33b.wav")
        .wr("我不会为了电脑付钱的。", "line33c.wav")
        
        .createNew()
        .p("好， 一共6770元。", "line34.wav", 0, 5, 0)
        
        .createNew()
        .p("你需要多少个100元和10元的纸币去副6670元呢?", "line35.wav", 5, 0, 0)
        .cr("67个100元纸币和7个10元纸币。", "line36a.wav")
        .wr("45个100元纸币和8个10元纸币。", "line36b.wav")
        .wr("124个100元纸币和5个10元纸币。", "line36c.wav")
        
        .createNew()
        .p("谢谢您光临本店!", "line37.wav", 0, 5, 0)
        .cr("谢谢您,再见!", "line38a.wav")
        .wr("不用了,谢谢你。", "line38b.wav")
        .wr("请给我好吗。", "line38c.wav")
    
        .build()
}
