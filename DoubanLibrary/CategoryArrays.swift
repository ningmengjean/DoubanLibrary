//
//  CategoryArrays.swift
//  DoubanLibrary
//
//  Created by wangchi on 2018/2/10.
//  Copyright © 2018年 Zhu xiaojin. All rights reserved.
//

import Foundation

struct CategoryArrays {
    var originalNovelist = ["爱情小说","青春小说","文艺小说","都市小说","科幻小说","幻想小说","武侠小说","悬疑小说","推理小说","历史小说","故乡小说","海外小说","职业故事","喜剧故事","图画故事"]
    var originalNonNovelist = ["文艺散文","评论随笔","文化","历史纪实","情感成长","旅行游记","生活","风尚","科技科普","行业","摄影","漫画绘本","设计艺术","诗歌","剧本"]
    var chineseEbookNovelist = ["世界名著","影视原著","推理悬疑","科幻","言情","青春","都市","幻想","武侠","历史","官场","军事战争","中国古典","中国现代","中国当代","外国现当代","中短篇集","其他"]
    var chineseEbookLiterary = ["文学经典","散文随笔","日记书信","演讲访谈","纪实文学","传记回忆","诗歌及赏析","戏剧曲艺","寓言童话","文学史","文学理论与批评","其他"]
    var chineseEbookHumanitiesSocialSciences = ["经典著作","心理学","社会学","人类学","历史","哲学","文化","宗教","政治","法律","教育学","新闻传播","编辑出版","考古","人文地理","语言文字","军事","其他"]
    var chineseEbookEcomonicManagement = ["经典畅销","创新创业","市场营销","企业经理","投资理财","领导力","财务会计","经济","金融","管理","其他"]
    var chineseEbookScience = ["科普百科","数学","物理","化学","天文","生物","医学","自然地理","城市建设","工业技术","农业技术","其他"]
    var chineseEbookComputerAndInternet = ["行业趋势","云计算与大数据","移动互联网","互联网营销","办公软件指南","编程语言","软件开发与应用","硬件开发","网络安全","人工智能","其他"]
    var chineseEbookSuccess = ["成功学","励志","情商与自我提升","思维智力","演讲口才","职场","人脉与人际关系","其他"]
    var chineseEbookLife = ["两性情感","旅行","美食与厨艺","时尚美妆","孕产育儿","养生保健","医学常识","家庭医学","体育健身","星座占卜","游戏娱乐","宠物园艺","其他"]
    var chineseEbookChild = ["家庭教育","亲子阅读","儿童文学","启蒙读本","少儿科普","其他"]
    var chineseEbookArtAndDesign = ["设计","摄影","电影","音乐","美术","建筑","其他"]
    var chineseEbookComicbook = ["漫画","绘本","其他"]
    var chineseEbookEducation = ["外语学习","教材教铺","国外教材","其他"]
    var chineseEbookMagzine = ["小说视界","新闻人物","文艺小赏","生活休闲","百科万象"]
    var ebookLiterature = ["Classics\n经典文学","Popular Literature\n通俗文学","World Literature\n世界文学","Mystery,Thriller & Suspense\n悬疑，惊悚与推理","Romance\n浪漫小说","Science Fiction\n科幻小说","Humor & Satire\n幽默与讽刺","Literary Fiction\n文艺小说","Mythology & Folk Tales\n神话与民间故事","Historical Fiction\n历史小说","Political & Military Fiction\n政治与军事小说","Essays & Correspondence\n散文与书信","Speech & Discourse\n演讲与演说","Drama & Plays\n戏剧","Poetry\n诗歌","Short Stories & Anthologies\n短篇与选集","History & Criticism\n文学史与文学评论","TV,Movie & Game\n影视游戏相关作品","Graphic Novels\n绘本小说","Narrative Nonfiction\n纪实文学"]
    var ebookBiographies = ["Historical\n历史人物","Military & Political\n军事与政治","Ethnic & National\n种族与民族","Arts & Literature\n艺术与文学","Professionals & Academic\n专业人士与学者","Famous & Royalty\n名流与皇室","Science & Technology\n科技界","Athletes\n运动员","True Crime\n犯罪","Specific Groups\n特殊群体"]
    var ebookHistory = ["History\n历史","Politics & Government\n政治与政府","Law\n法律","Journalism & Communication\n新闻传播","Education\n教育学","Linguistics\n语言学","Psychology\n心理学","Anthropology\n人类学","Archaeology\n考古学","Sociology\n社会学","Phiosophy\n哲学","Religions\n宗教","Social Sciences\n社会科学","Reference\n参考书"]
    var ebookBusiness = ["Management & Leadership\n管理与领导力","Marketing & Sales\n营销与销售","Human Resources\n人力资源","Industires\n行业","Real Estate\n房地产","Wealth Management\n财富管理","Startups\n创业企业","Economics\n经济学","Finance\n金融","Accounting\n会计","Investing\n投资","Taxation\n税务","Skills & Business Writing\n商业技巧与商务写作"]
    var ebookSelfhelp = ["Success\n成功","Creativity\n创造力","Time Management\n时间管理","Self-Improvement\n自我提升","Job Hunting & Career Life\n求职与职场生活","Sccial Skills\n社交能力","Psychology & Counseling\n心理问题与咨询","Marriage & Adult Relationships\n婚姻与成人关系","Family Relationships\n家庭关系","Spiritual\n身心灵"]
    var ebookComputer = ["Computer Science\n计算机科学","Software & Apps\n软件与应用","Programming & Development\n编程与开发","Business & Management\n商业与管理","Databases & Big Data\n数据库与大数据","Social Media\n社交媒体","Web Marketing\n网络营销","Internet Security\n网络安全","Web Design\n网络设计","Games & Strategy Guides\n游戏设计与攻略","Industry Trends\n行业趋势"]
    var ebookScience = ["Mathematics\n数学","Physics\n物理学","Astronomy & Space Science\n天文学与空间科学","Chemistry\n化学","Medicine\n医学","Biology\n生物学","Earth Sciences\n地球科学","Environmental Science\n环境科学","Nature & Ecology\n自然与生态","Agricultural Sciences\n农业科学","Engineering & Technology\n工程与技术","Life Sciences\n生命科学","Research & Reference\n科研与参考书","Popular Science\n科普读物"]
    var ebookChildren = ["Literature\n文学","Mysteries & Thrillers\n推理与惊悚","Science Fiction & Fantasy\n科幻与奇幻","Love & Romance\n爱情与浪漫","Historical Fiction\n历史小说","Health,Mind & Body\n身心健康","Scocial & Family Issues\n社会与家庭问题","Sports & Games\n运动与游戏","Comic Strips & Cartoons\n连环漫画与卡通","Education & Reference\n教育与参考书","Arts,Music & Photography\n艺术，音乐与摄影","Fairy Tales,Folk Tales & Myths\n童话，民间故事与神话","Encyclopedia\n百科"]
    var ebookHealth = ["Health & Diseases\n健康与疾病","Children's Health\n儿童健康","Nutrition\n营养学","Diets & Weight Loss\n饮食控制与减重","Beauty & Style\n美容与造型","Addiction & Recovery\n上瘾与康复","Baking\n烘焙","Beverages & Wine\n饮品与酒","General Cookery & Recipes\n日常烹饪与菜谱","Global Cuisine & Recipes\n国际美食与烹饪","Pets Care\n宠物","Exercise & Fitness\n锻炼与健身","Parenting & Education\n养育与教育","Gardening,Crafts & Collectibles\n园艺，手工与收藏","Home Design\n家具设计","Humor & Entertainment\n幽默与娱乐","Weddings\n婚礼"]
    var ebookArt = ["Drawing\n绘画","Architecture\n建筑","Collections,Catalogs & Exhibitions\n收藏与展览","Design\n设计","Painting & Sculpture\n绘画与雕塑","Photography\n摄影","Music\n音乐","Art History & Criticism\n艺术史与评论","Pop Culture\n流行文化","Film\n电影","Media & Performing Arts\n媒体与表演艺术","Fashion\n时尚"]
    var ebookTravel = ["Food,Lodging & Transportation\n饮食，住宿与交通","Europe\n欧洲","Russia\n俄罗斯","Japan\n日本","Asia\n亚洲","Middle East\n中东","Southeast Asia\n东南亚","North America\n北美","Central & South America\n中美洲与南美洲","Africa\n非洲","Australia & South Pacific\n澳洲与南太平洋","Polar Regions\n两极地区","Adventure Travel\n探险","Travel Writing\n游记"]
    var ebookSports = ["Ball Games\n球类运动","Athletics\n田径","Water Sports\n水上运动","Winter Sports\n冬季运动","Training\n训练","Outdoor Sports\n户外运动","Extreme Sports\n极限运动","Other Sports\n其他运动"]
}





















