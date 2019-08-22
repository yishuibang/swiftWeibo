//
//  WBAuthViewController.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/5/26.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit
import SVProgressHUD
//通过webView 加载新浪微博授权界面
class WBAuthViewController: UIViewController {
fileprivate lazy var webView = UIWebView()
    override func loadView() {
        //设置代理
        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
        view = webView
        view.backgroundColor = UIColor.white
        navigationItem.title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", taget: self, action: #selector(back), isBackbutton: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", taget: self, action: #selector(autoFill), isBackbutton: false)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载授权界面
        let urlstring = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_uri=\(WBRedirectURL)"
        print(urlstring)
        guard let url = URL(string: urlstring)
         else {
            return
        }
        
        let  request = URLRequest(url: url)
        webView.loadRequest(request)
        
    }
    func back() {
        SVProgressHUD.dismiss()
       dismiss(animated: true, completion: nil)
    }
    
    //自动填充 - webView的注入 通过js修改本地浏览器缓存中的页面
    /// 点击登录按钮 执行js submit（） 将本地数据提交给服务器
    
    func autoFill() {
        //准备js 
        let js = "document.getElementById('userId').value='18300601892';" + "document.getElementById('passwd').value='JFang123';"
        //让webView 执行js
        webView.stringByEvaluatingJavaScript(from: js)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension WBAuthViewController:UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //是否加载request 
        print("加载请求  、\(String(describing: request.url?.absoluteString))")
        //query  查询字符串  ？后面的部分
        print("加载请求 、、\(String(describing: request.url?.query))")
        //1.加载的url是否有http://baidu.com 不加载  否则加载页面
        //request.url?.absoluteString.hasPrefix(WBRedirectURL) 可选 bool/nil
        if request.url?.absoluteString.hasPrefix(WBRedirectURL) == false {
            return true
        }
        
        // 从http://baidu.com url回调地址中查寻字符串找’code=‘ 如果有授权成功 如果没有授权失败
        if request.url?.query?.hasPrefix("code=") == false {
            print("授权失败。。。。。。。")
            back()
            return false
        }
        
        //从qurey 中取出授权码 代码走到此处一定有查询字符串  一定有code
      let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""//?？后面的
        print("获取授权码 \(code)")
        WBNetWorkManger.share.accessToken(code: code, composetion: {(isSuccess:Bool) in
            if isSuccess{
                //SVProgressHUD.showInfo(withStatus: "登录成功！")
                //下一步跳转界面 如何跳转
                //发送登录成功消息  不关心监听者是否监听 只关注通知的发送
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserLoginSuccessNotification), object: nil)
                //关闭窗口
                self.back()
                
            }else{
                SVProgressHUD.showInfo(withStatus: "登录失败！")
                
            }
        })
        SVProgressHUD.dismiss()
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
