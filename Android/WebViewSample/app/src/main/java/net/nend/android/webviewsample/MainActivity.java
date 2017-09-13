package net.nend.android.webviewsample;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.support.annotation.RequiresApi;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.ViewGroup.LayoutParams;
import android.view.WindowManager;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class MainActivity extends Activity {

    /** TAG */
    private static final String TAG = "nend_WebView_sample";

    /** 広告用WebView */
    private WebView mWebViewNendAd = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.i(TAG, "MainActivity onCreate() start...");

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 1. スクリーン密度を取得
        DisplayMetrics metrics = new DisplayMetrics();
        ((WindowManager)getApplicationContext().getSystemService(Context.WINDOW_SERVICE)).getDefaultDisplay().getMetrics(metrics);

        // 2. 作成、ロード
        createNendAd(metrics.density);

        Log.i(TAG, "MainActivity onCreate() finish...");
    }

    @Override
    protected void onDestroy() {
        // 3. 停止、破棄
        deallocateNendAd();

        super.onDestroy();
    }

    /**
     * 広告用WebView生成
     */
    @SuppressLint("SetJavaScriptEnabled")
    private void createNendAd(float density){
        Log.i(TAG, "MainActivity createNendAd()");

        deallocateNendAd();

        // WebViewを利用して広告バナーを作成
        mWebViewNendAd= new WebView(getApplicationContext());
        mWebViewNendAd.getSettings().setJavaScriptEnabled(true);
        mWebViewNendAd.loadUrl("file:///android_asset/nendAd.html");

        // 広告バナータップ時に新規ウィンドウで開くためにWebViewClientのメソッドをOverrideしたインスタンスを指定
        // 注意: 下記は一例です。別途クラスを作成しても構いませんが、必ずリンク先をブラウザで開くための処理を記述してください。
        //       対処しない場合、広告バナーと同じWebView内でリンク先のページが開く場合があります。
        mWebViewNendAd.setWebViewClient(new WebViewClient() {
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
                startActivity(intent);
                return true;
            }

            @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(request.getUrl().toString()));
                startActivity(intent);
                return true;
            }
        } );

        // 注意：配置先については適宜変更してください
        addContentView(mWebViewNendAd, new LayoutParams((int) (320 * density), (int) (50 * density)));
    }

    /**
     * 広告用WebView破棄
     */
    private void deallocateNendAd() {
        if (mWebViewNendAd != null) {
            Log.i(TAG, "MainActivity deallocateNendAd()");
            mWebViewNendAd.stopLoading();
            mWebViewNendAd.getSettings().setJavaScriptEnabled(false);
            mWebViewNendAd.setWebViewClient(null);
            mWebViewNendAd.destroy();
            mWebViewNendAd = null;
        }
    }
}
