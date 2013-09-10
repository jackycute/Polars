Polars 極地探險
===============

Intro 簡介
----------
Polars is a mobile(phone or tablet) puzzle game based on the Arctic environment.  
***極地探險是一款以北極環境為基礎的行動裝置(手機或是平板) 解謎遊戲。***  
Target Platform: [Android] [ANDROID-DASHBOARD] API Level 9 (so called SDK 2.3) above.  
***目標平台：[Android] [ANDROID-DASHBOARD] API Level 9 (so called SDK 2.3) 或是更高。***  
Using Emo-Framework as game framework.  
***使用Emo-Framework作為遊戲框架。***  
And using [Tiled] [Tiled-WWW] as map editor.  
***以及使用[Tiled] [Tiled-WWW] 作為地圖編輯器。***  

> - [Here] [Tiled-Format] is the Tiled Format Reference.  
> - ***[這裡] [Tiled-Format] 是Tiled的格式參考。***  
> - Tutorial about how to use Tiled The Map Editor [Part1] [Tile-Tutorial-1] & [Part2] [Tile-Tutorial-2].  
> - ***如何使用Tiled地圖編輯器的教學 [Part1] [Tile-Tutorial-1] & [Part2] [Tile-Tutorial-2]。***  

Planning 企劃
--------
Please move to Google Drive in [here] [POLARS-GD].  
***請移至Google Drive [在這裡] [POLARS-GD].***  

About Engine 關於引擎
------------
The Game Engine(or Framework) using in Polars is called Emo-Framework:  
***在極地探險使用的遊戲引擎(也就是框架)叫做 Emo-Framework：***  

 - [Official Website ***官方網站***] [EMO-WWW]
 - [Google Project ***Google專案***] [EMO-Google]

However, The author doesn't maintain that project anymore instead of another developer called Tedd Broiler takeover.  
***不過，因為EMO的作者已經不再維護它了，而是一位叫做Tedd Broiler來接手。***  
So, We're using a experiment branch of EMO in [here] [EMO-BRANCH].  
***所以，我們使用的是一個實驗性的EMO分支版本，[在這裡] [EMO-BRANCH]可以看到。***  

To develope in EMO, the best way is using the latest [ADT Bundle] [ADT-Bundle] with SQDev plugin(link is on below!).  
***開發EMO最佳的選擇是使用[ADT Bundle] [ADT-Bundle]懶人包加上SQDev外掛(連結在下面！)。***  

Coding References 程式參考
-----------------
The programming languages we're using to developing game is called  [Squirrel] [SQ-Wiki].  
***開發中我們主要使用的程式語言是 [Squirrel] [SQ-Wiki]。***  
Here are some resources that is good for learning about this languages:  
***這裡有一些很棒的資源來供你學習它：***  

 - [Squirrel Standard Library 3.0 ***Squirrel 3.0標準函式庫***] [SQ-STDLIB]  
 - [Squirrel 3.0 Reference Manual ***Squirrel 3.0使用手冊***] [SQ-MANUAL]  
 - [SQDev Update Site ***SQDev更新站***] [SQ-DEV]  

The original EMO API Reference is in [here] [EMO-API].  
***原版的EMO API參考[在這裡] [EMO-API]。***  
And some additional features which in EMO branch is [here] [EMO-NEW-API].  
***還有EMO分支版新增加的功能[在這裡] [EMO-NEW-API]。***  

[ANDROID-DASHBOARD]: http://developer.android.com/about/dashboards/index.html
[ADT-Bundle]: http://developer.android.com/sdk/index.html#download
[EMO-WWW]: http://www.emo-framework.com/
[EMO-Google]: https://code.google.com/p/emo-framework/
[EMO-BRANCH]: https://github.com/team-emo/emo-framework
[EMO-API]: https://code.google.com/p/emo-framework/wiki/APIReference
[EMO-NEW-API]: https://github.com/team-emo/emo-framework/wiki/Additional-Features
[SQ-Wiki]: http://en.wikipedia.org/wiki/Squirrel_(programming_language)
[SQ-STDLIB]: http://www.squirrel-lang.org/doc/sqstdlib3.html
[SQ-MANUAL]: http://www.squirrel-lang.org/doc/squirrel3.html
[SQ-DEV]: http://sqdev.sf.net/update/
[Tiled-WWW]: http://www.mapeditor.org/
[Tiled-Format]: https://github.com/bjorn/tiled/wiki/TMX-Map-Format
[Tile-Tutorial-1]: http://gamedev.tutsplus.com/tutorials/level-design/introduction-to-tiled-map-editor/
[Tile-Tutorial-2]: http://gamedev.tutsplus.com/tutorials/implementation/parsing-tiled-tmx-format-maps-in-your-own-game-engine/
[POLARS-GD]: https://drive.google.com/folderview?id=0B1o0hcarX5SFMnlzVi01Ym1RZm8&usp=sharing
