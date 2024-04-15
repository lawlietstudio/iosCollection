//
//  ContentView.swift
//  20240228TabView
//
//  Created by Mark Ho on 28/2/2024.
//

import SwiftUI

struct ContentView: View {
    @State var currentTab = 0
    var body: some View {
        ScrollView {
            Picker("Options", selection: $currentTab) {
                Text("Tab 1").tag(0)
                Text("Tab 2").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            
            TabView(selection: $currentTab) {
                if currentTab == 0 {
                    Text("""
                         Dissuade ecstatic and properly saw entirely sir why laughter endeavor. In on my jointure horrible margaret suitable he followed speedily. Indeed vanity excuse or mr lovers of on. By offer scale an stuff. Blush be sorry no sight. Sang lose of hour then he left find.
                         
                         Now indulgence dissimilar for his thoroughly has terminated. Agreement offending commanded my an. Change wholly say why eldest period. Are projection put celebrated particular unreserved joy unsatiable its. In then dare good am rose bred or. On am in nearer square wanted.
                         
                         Old education him departure any arranging one prevailed. Their end whole might began her. Behaved the comfort another fifteen eat. Partiality had his themselves ask pianoforte increasing discovered. So mr delay at since place whole above miles. He to observe conduct at detract because. Way ham unwilling not breakfast furniture explained perpetual. Or mr surrounded conviction so astonished literature. Songs to an blush woman be sorry young. We certain as removal attempt.
                         
                         Greatly cottage thought fortune no mention he. Of mr certainty arranging am smallness by conveying. Him plate you allow built grave. Sigh sang nay sex high yet door game. She dissimilar was favourable unreserved nay expression contrasted saw. Past her find she like bore pain open. Shy lose need eyes son not shot. Jennings removing are his eat dashwood. Middleton as pretended listening he smallness perceived. Now his but two green spoil drift.
                         
                         Him rendered may attended concerns jennings reserved now. Sympathize did now preference unpleasing mrs few. Mrs for hour game room want are fond dare. For detract charmed add talking age. Shy resolution instrument unreserved man few. She did open find pain some out. If we landlord stanhill mr whatever pleasure supplied concerns so. Exquisite by it admitting cordially september newspaper an. Acceptance middletons am it favourable. It it oh happen lovers afraid.
                         
                         Left till here away at to whom past. Feelings laughing at no wondered repeated provided finished. It acceptance thoroughly my advantages everything as. Are projecting inquietude affronting preference saw who. Marry of am do avoid ample as. Old disposal followed she ignorant desirous two has. Called played entire roused though for one too. He into walk roof made tall cold he. Feelings way likewise addition wandered contempt bed indulged.
                         
                         Can curiosity may end shameless explained. True high on said mr on come. An do mr design at little myself wholly entire though. Attended of on stronger or mr pleasure. Rich four like real yet west get. Felicity in dwelling to drawings. His pleasure new steepest for reserved formerly disposed jennings.
                         
                         Far quitting dwelling graceful the likewise received building. An fact so to that show am shed sold cold. Unaffected remarkably get yet introduced excellence terminated led. Result either design saw she esteem and. On ashamed no inhabit ferrars it ye besides resolve. Own judgment directly few trifling. Elderly as pursuit at regular do parlors. Rank what has into fond she.
                         
                         Arrival entered an if drawing request. How daughters not promotion few knowledge contented. Yet winter law behind number stairs garret excuse. Minuter we natural conduct gravity if pointed oh no. Am immediate unwilling of attempted admitting disposing it. Handsome opinions on am at it ladyship.
                         
                         Sussex result matter any end see. It speedily me addition weddings vicinity in pleasure. Happiness commanded an conveying breakfast in. Regard her say warmly elinor. Him these are visit front end for seven walls. Money eat scale now ask law learn. Side its they just any upon see last. He prepared no shutters perceive do greatest. Ye at unpleasant solicitude in companions interested.
                         """)
                } else {
                    
                    Text("""
                         冒認收了 玉，不題 吉安而來 父親回衙. 樂而不淫 分得意 ﻿白圭志 第十一回 後竊聽 不稱讚. 誨 覽 去 耳 矣 曰：. 曰： 關雎 覽 誨 去 意 事 耳. 玉，不題 吉安而來 汗流如雨 父親回衙 冒認收了. 出 關雎 曰： 矣. 建章曰： 後竊聽 樂而不淫 分得意 以測機. 出 耳 矣 關雎. 冒認收了 去 父親回衙 ，可 關雎 矣 誨 」 汗流如雨 意 覽 吉安而來. 不稱讚 以測機 危德至 訖乃返 第十一回 分得意. 」 耳 事 矣 去. 第六回 第四回 第九回 去 關雎 覽 曰： 意. 關雎 耳 曰： 意 」 誨. 去 出 誨 事. 耳 覽 誨 矣 意 出 曰： 」. ，可 矣 關雎 出 耳 誨. 饒爾去罷」 此是後話 也懊悔不了 ，愈聽愈惱. 吉安而來 汗流如雨 冒認收了 父親回衙 玉，不題. 驚異 第六回 第四回 不題 了」.
                         
                         訖乃返 樂而不淫 危德至 不稱讚. 此是後話 饒爾去罷」 ，愈聽愈惱. 事 曰： 」 意 關雎. 矣 」 覽 ，可 誨 出. 誨 覽 」 出. 事 覽 玉，不題 耳 父親回衙 ，可 關雎 汗流如雨 冒認收了. ，可 去 出 覽 曰： 」 誨 事. 饒爾去罷」 ，愈聽愈惱 曰： 耳 事 覽 也懊悔不了 此是後話 誨. 事 出 意 覽 誨. 關雎 耳 出 也懊悔不了 矣 此是後話 ，愈聽愈惱 事 意. 貢院 第三回 招」. 關雎 耳 」 意. 貢院 不題 第一回 第四回 德泉淹 驚異. 也懊悔不了 ，愈聽愈惱 此是後話 饒爾去罷」. 誨 事 出 關雎 意 去 矣 覽. 驚異 第十回 第七回 第一回 了」. 後竊聽 ﻿白圭志 以測機 第十一回 危德至 訖乃返. 危德至 不稱讚 ﻿白圭志 第十一回.
        
                         ，可 意 耳 覽 曰： 」 事 誨. 也懊悔不了 ，愈聽愈惱 饒爾去罷」. 覽 出 耳 去 關雎 」 ，愈聽愈惱 此是後話 饒爾去罷」 ，可. 吉安而來 事 父親回衙 去 玉，不題 誨 覽 汗流如雨 關雎 冒認收了 矣. 吉安而來 曰： 玉，不題 出 冒認收了 關雎 父親回衙 汗流如雨 」. 第九回 相域 不題. 招」 第十回 第一回 第三回 第八回. 第七回 第三回 第九回 相域 羨殺 德泉淹. 樂而不淫 ，可 出 覽 訖乃返 耳 矣 意 不稱讚 建章曰： 在一處 己轉身 事 去. ，愈聽愈惱 也懊悔不了 此是後話 饒爾去罷」. 去 耳 意 覽 誨 事 曰：. 汗流如雨 玉，不題 父親回衙. 羨殺 第十回 德泉淹 不題. 也懊悔不了 出 此是後話 ，可 去 耳 饒爾去罷」 關雎 ，愈聽愈惱. 吉安而來 父親回衙 汗流如雨 玉，不題. 第九回 第三回 羨殺 德泉淹. 訖乃返 ﻿白圭志 樂而不淫. 訖乃返 在一處 後竊聽 樂而不淫.
        
                         意 關雎 去 覽 矣 曰： 誨. 去 曰： 覽 關雎 事 意. 意 出 關雎 耳 誨 去 覽. 」 事 第八回 不題 曰： 羨殺 第三回 誨 第一回. 去 ，可 耳 意 關雎 誨 矣 覽. 曰： 」 出 誨 意 事 ，可. 父親回衙 汗流如雨 玉，不題 冒認收了. 第十一回 樂而不淫 以測機 建章曰： 危德至. 訖乃返 不稱讚 第十一回 建章曰： 意 己轉身 關雎 事 後竊聽 曰： 去 誨 覽. 去 關雎 耳 ，可 」 曰： 矣. 意 矣 」 ，可 曰：. 去 意 覽 ，可. 父親回衙 」 出 玉，不題 誨 事 ，可 吉安而來 冒認收了 去 曰： 覽. 耳 此是後話 ，愈聽愈惱 也懊悔不了 曰： 矣 饒爾去罷」 去 出 」. 冒認收了 汗流如雨 吉安而來. 誨 」 矣 關雎 事 曰： 覽 ，可. 誨 」 曰： 耳 覽 去 關雎 意. 關雎 事 羨殺 ，可 第十回 耳 了」 招」 矣 德泉淹 第七回 覽 去. 饒爾去罷」 也懊悔不了 耳 覽 此是後話 ，愈聽愈惱 ，可 矣 」. 第二回 德泉淹 第一回 第七回 不題 第九回. 在一處 以測機 分得意 不稱讚. 矣 ，可 事 曰： 去 意 」. 也懊悔不了 此是後話 ，愈聽愈惱 饒爾去罷」.
        
                         也懊悔不了 ，愈聽愈惱 饒爾去罷」 此是後話. ，可 」 事 覽 出 汗流如雨 父親回衙 耳 矣 玉，不題 意. 出 耳 曰： 覽 」 意. 去 耳 」 出 矣 事 覽. 此是後話 饒爾去罷」 也懊悔不了. 事 」 關雎 去 ，可. 耳 去 矣 」 覽 意 曰： 關雎. ，可 意 矣 耳 曰：. 曰： 誨 事 去 意 」. 第六回 第三回 不題 第八回 第十回. 矣 ，可 事 去 意. 事 覽 意 ，可 去 關雎 出 耳. 意 耳 事 去 矣 ，可 覽. 了」 第一回 第三回 招」. 誨 曰： 耳 覽 出 關雎. 己轉身 在一處 後竊聽 分得意 訖乃返.
        
                         事 關雎 出 誨 」 意 覽. 也懊悔不了 此是後話 饒爾去罷」 ，愈聽愈惱. 曰： 關雎 意 ，可 出 事. 覽 事 曰： 去. 不題 第四回 羨殺. 」 誨 覽 ，可. 去 ，可 此是後話 覽 出 也懊悔不了 ，愈聽愈惱 饒爾去罷」. 不題 第十回 第一回 第五回. ，可 意 曰： 誨 矣 耳 關雎. 耳 去 覽 關雎 ，可 矣 事 誨. 德泉淹 羨殺 貢院. 曰： 去 」 事 覽. 父親回衙 冒認收了 吉安而來 玉，不題 汗流如雨. 建章曰： 後竊聽 出 己轉身 事 ，可 關雎 訖乃返 不稱讚 覽. 此是後話 ，愈聽愈惱 饒爾去罷」 也懊悔不了. 去 ，可 意 覽.
        
                         意 去 出 誨 覽 關雎. 去 」 ，可 意 矣 誨. 耳 誨 意 事 去 矣 曰：. 事 覽 關雎 矣 去 誨 意 ，可. 玉，不題 汗流如雨 吉安而來 冒認收了 父親回衙. 了」 第七回 第八回 第三回 相域. 矣 耳 」 意 曰：. 第六回 第二回 了」. 矣 關雎 曰： 出 覽 誨 」 耳. 也懊悔不了 饒爾去罷」 此是後話. 汗流如雨 冒認收了 吉安而來 父親回衙 玉，不題. ，愈聽愈惱 也懊悔不了 饒爾去罷」. 第八回 第四回 事 第六回 關雎 出 去. 吉安而來 玉，不題 汗流如雨 冒認收了 父親回衙. 後竊聽 以測機 危德至. 第九回 去 耳 第六回 誨 事 驚異 」. 也懊悔不了 ，愈聽愈惱 饒爾去罷」 此是後話. 父親回衙 冒認收了 吉安而來 玉，不題 汗流如雨. 危德至 訖乃返 意 不稱讚 去 覽 」 矣 ﻿白圭志. 饒爾去罷」 此是後話 也懊悔不了 ，愈聽愈惱.
        
                         羨殺 驚異 貢院 第六回 第一回. 玉，不題 父親回衙 汗流如雨 冒認收了 吉安而來. 事 覽 關雎 意 耳 誨 曰：. ﻿白圭志 以測機 後竊聽 不稱讚 危德至 建章曰：. 饒爾去罷」 ，愈聽愈惱 此是後話 也懊悔不了. 也懊悔不了 饒爾去罷」 此是後話 ，愈聽愈惱. 意 去 」 事 出. ，可 矣 」 覽 事 誨. 第五回 第一回 第六回 羨殺 第八回 驚異. 危德至 己轉身 分得意 在一處 矣 覽 」 去 後竊聽 耳. 不稱讚 危德至 後竊聽 以測機. 訖乃返 矣 」 誨 覽 不稱讚 樂而不淫 耳 出 分得意 關雎 ，可. 耳 誨 」 出 關雎 意 事. 也懊悔不了 饒爾去罷」 ，愈聽愈惱 此是後話. 曰： 關雎 」 ，可 出 覽 事 矣. 誨 關雎 ，可 意 」. 建章曰： 訖乃返 不稱讚 危德至 後竊聽 分得意. 耳 ，可 ，愈聽愈惱 此是後話 關雎 也懊悔不了 饒爾去罷」 去 誨 」 意. 」 誨 ，可 關雎 出 去 曰：.
        
                         」 事 覽 出 去. 分得意 建章曰： 訖乃返. 危德至 意 在一處 耳 事 分得意 矣 第十一回 去 覽 關雎 以測機 ，可. 危德至 在一處 分得意 樂而不淫. 覽 矣 去 耳. 」 關雎 玉，不題 矣 曰： 吉安而來 冒認收了 誨 去 覽 意. 出 曰： ，可 」 矣 意 耳. 意 事 出 去. 耳 誨 意 去 ，可 關雎 事. 冒認收了 吉安而來 父親回衙 玉，不題. ﻿白圭志 曰： 矣 」 不稱讚 ，可 事 關雎 在一處 意 樂而不淫 己轉身 訖乃返. 矣 去 曰： 」 覽 耳 ，可. 矣 了」 第七回 關雎 耳 曰： 德泉淹. 第四回 驚異 第十回 招」. 耳 意 出 事 關雎 覽 」. 矣 關雎 曰： 誨. 貢院 第三回 第十回. ，愈聽愈惱 饒爾去罷」 此是後話. ，愈聽愈惱 饒爾去罷」 ，可 也懊悔不了 關雎 去 此是後話 出. 驚異 ，可 」 招」 曰： 第一回 誨 事 第七回 第五回 覽 羨殺 出. 也懊悔不了 此是後話 饒爾去罷」. ，可 不稱讚 」 曰： 去 己轉身 建章曰： 出 覽 訖乃返 事 意 以測機. 曰： 關雎 去 意 誨. 誨 」 關雎 曰： 矣 事. ，可 曰： 」 關雎 矣 分得意 覽 後竊聽 建章曰： 出.
        
                         饒爾去罷」 也懊悔不了 此是後話 ，愈聽愈惱. 去 耳 關雎 事 曰： 意. 意 矣 父親回衙 汗流如雨 誨 曰： 吉安而來 玉，不題 冒認收了 事. 去 」 矣 意. 出 耳 ，可 」 誨 事 關雎. 饒爾去罷」 」 意 ，愈聽愈惱 出 誨 矣 也懊悔不了 覽 關雎. 此是後話 矣 意 饒爾去罷」 也懊悔不了 出 關雎 事 ，愈聽愈惱. ﻿白圭志 樂而不淫 危德至. 分得意 樂而不淫 在一處 危德至. 也懊悔不了 此是後話 ，愈聽愈惱. 誨 出 曰： ，可 事 意 去 覽. 出 去 事 誨 覽 關雎. 耳 第三回 第二回 貢院 意 誨 矣 去 德泉淹 出. 覽 ，可 耳 矣. 第十一回 建章曰： 不稱讚 危德至 在一處 訖乃返. 第四回 了」 招」 第十回.
        """)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
