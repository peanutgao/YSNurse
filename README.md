# YSNurse
A tool which can help you avoid project crash

	
* 因为公司项目开发时间很赶, 有时半个月一个完整的项目2个客户端就得开发结束, 大家在开发中不免会出现考虑不周全、测试时间短导致上线后出现一些崩溃问题，而崩溃直接影响粮草，所以最好考虑写了这个轮子。
YSNurse用的是通过Method Swizzling，在自己的方法中添加了一些判断。当初在考虑开发的过程中时和同事沟通，原本想偷懒直接用@try-@catch的方法直接不活异常，然后啥都不干，但因为@try-@catch效率太低，而且即使在ARC下也会导致内存泄漏(苹果也提示少用@try-@catch, 多用NSError)。至于为什么会导致内容泄露可以看[这里](http://stackoverflow.com/questions/27140891/why-does-try-catch-in-objective-c-cause-memory-leak)。所以最后还是决定通过添加判断来避免程序的崩溃。

* 有些朋友很害怕用Runtime，觉得如果出现问题很难定位。其实通过查看调用堆栈很容易就能看到是哪里出的问题。同时也为了让开发中避免来回跳方法、更快的定位错误，在每个方法交换中都做了相对详细的错误提示，提示的内容也尽量和之前Xcode提示的错误一致，也没有将一些通用的方法抽离出来，减少跳方法的问题，但是缺点就是代码会有点多，可是对于项目时间比较赶而言我觉得还是值得的。
* 对于一些特殊的方法：如KVC等，我最后选择用了@try-@catch，因为系统频繁掉用，不做特殊处理会更安全些。不过添加了空判断。
* 开发中对照着官方文档一个个写可能导致崩溃的常用的方法，基本支持下面常用方法等错误判断
	* NSArray
	* NSMutableArray
	* NSDictionary
	* NSMutableDictionary
	* NSString
	* NSMutableString
	* NSAttributeString
	* NSMutableAttributeString
	* NSObject

* 除此之外, 在开发中经常也会出现 `unrecognized selector sent to instance` 的错误. 我也做了处理减少这个问题导致的崩溃(还无法做到全部).
* 更多的可以看Demo,
* 有问题或者有更好的建议欢迎提Issues