package com.flappy.flutterflappyrequest;

import com.flappygo.lilin.lxhttpclient.Asynctask.LXAsyncCallback;
import com.flappygo.lilin.lxhttpclient.Exception.LXHttpException;
import com.flappygo.lilin.lxhttpclient.HttpTask.LXHttpTask;
import com.flappygo.lilin.lxhttpclient.HttpTask.LXHttpsTask;
import com.flappygo.lilin.lxhttpclient.LXHttpClient;
import com.flappygo.lilin.lxhttpclient.LXHttpsClient;

import androidx.annotation.NonNull;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterflappyrequestPlugin
 */
public class FlutterflappyrequestPlugin implements FlutterPlugin, MethodCallHandler {
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutterflappyrequest");
        channel.setMethodCallHandler(new FlutterflappyrequestPlugin());
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutterflappyrequest");
        channel.setMethodCallHandler(new FlutterflappyrequestPlugin());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull final Result result) {
        //请求数据postParam
        if (call.method.equals("postParam")) {
            //请求
            String url = call.argument("url");
            //请求
            String header = call.argument("header");
            //请求
            String body = call.argument("body");
            //超时时间
            int timeout = Integer.parseInt((String) call.argument("timeout"));
            //https请求
            if (url.startsWith("https")) {
                //转换为task
                LXHttpsTask task = new LXHttpsTask(url, jsonToHashMap(body));
                //设置超时时间
                task.setConnectTimeOut(timeout);
                //转换为
                HashMap<String, Object> headerMap = jsonToHashMap(header);
                //装换为header
                for (String key : headerMap.keySet()) {
                    task.addRequestProperty(key, headerMap.get(key).toString());
                }
                //发送post信息
                LXHttpsClient.getInstacne().postParam(task, new LXAsyncCallback<String>() {
                    @Override
                    public void failure(Exception e, String tag) {
                        if (e instanceof LXHttpException) {
                            result.error((Integer.toString(((LXHttpException) e).getResponseCode())), e.getMessage(), e.getCause().toString());
                        } else {
                            result.error("-1", e.getMessage(), e.getCause().toString());
                        }
                    }

                    @Override
                    public void success(String data, String tag) {
                        result.success(data);
                    }
                });
            }
            //http请求
            else {
                //转换为task
                LXHttpTask task = new LXHttpTask(url, jsonToHashMap(body));
                //设置超时时间
                task.setConnectTimeOut(timeout);
                //转换为
                HashMap<String, Object> headerMap = jsonToHashMap(header);
                //装换为header
                for (String key : headerMap.keySet()) {
                    task.addRequestProperty(key, headerMap.get(key).toString());
                }
                //发送post信息
                LXHttpClient.getInstacne().postParam(task, new LXAsyncCallback<String>() {
                    @Override
                    public void failure(Exception e, String tag) {
                        if (e instanceof LXHttpException) {
                            result.error((Integer.toString(((LXHttpException) e).getResponseCode())), e.getMessage(), e.getCause().toString());
                        } else {
                            result.error("-1", e.getMessage(), e.getCause().toString());
                        }
                    }

                    @Override
                    public void success(String data, String tag) {
                        result.success(data);
                    }
                });
            }
        }
        //请求数据postJson
        else if (call.method.equals("postJson")) {
            //请求
            String url = call.argument("url");
            //请求
            String header = call.argument("header");
            //请求
            String body = call.argument("body");
            //超时时间
            int timeout = Integer.parseInt((String) call.argument("timeout"));
            //https请求
            if (url.startsWith("https")) {
                //转换为task
                LXHttpsTask task = new LXHttpsTask(url, jsonToHashMap(body));
                //设置超时时间
                task.setConnectTimeOut(timeout);
                //转换为
                HashMap<String, Object> headerMap = jsonToHashMap(header);
                //装换为header
                for (String key : headerMap.keySet()) {
                    task.addRequestProperty(key, headerMap.get(key).toString());
                }
                //发送post信息
                LXHttpsClient.getInstacne().post(task, new LXAsyncCallback<String>() {
                    @Override
                    public void failure(Exception e, String tag) {
                        if (e instanceof LXHttpException) {
                            result.error((Integer.toString(((LXHttpException) e).getResponseCode())), e.getMessage(), e.getCause().toString());
                        } else {
                            result.error("-1", e.getMessage(), e.getCause().toString());
                        }
                    }

                    @Override
                    public void success(String data, String tag) {
                        result.success(data);
                    }
                });
            }
            //http请求
            else {
                //转换为task
                LXHttpTask task = new LXHttpTask(url, jsonToHashMap(body));
                //设置超时时间
                task.setConnectTimeOut(timeout);
                //转换为
                HashMap<String, Object> headerMap = jsonToHashMap(header);
                //装换为header
                for (String key : headerMap.keySet()) {
                    task.addRequestProperty(key, headerMap.get(key).toString());
                }
                //发送post信息
                LXHttpClient.getInstacne().post(task, new LXAsyncCallback<String>() {
                    @Override
                    public void failure(Exception e, String tag) {
                        if (e instanceof LXHttpException) {
                            result.error((Integer.toString(((LXHttpException) e).getResponseCode())), e.getMessage(), e.getCause().toString());
                        } else {
                            result.error("-1", e.getMessage(), e.getCause().toString());
                        }
                    }

                    @Override
                    public void success(String data, String tag) {
                        result.success(data);
                    }
                });
            }
        } else if (call.method.equals("get")) {
            //请求
            String url = call.argument("url");
            //请求
            String header = call.argument("header");
            //请求
            String body = call.argument("body");
            //超时时间
            int timeout = Integer.parseInt((String) call.argument("timeout"));
            //https请求
            if (url.startsWith("https")) {
                //转换为task
                LXHttpsTask task = new LXHttpsTask(url, jsonToHashMap(body));
                //设置超时时间
                task.setConnectTimeOut(timeout);
                //转换为
                HashMap<String, Object> headerMap = jsonToHashMap(header);
                //装换为header
                for (String key : headerMap.keySet()) {
                    task.addRequestProperty(key, headerMap.get(key).toString());
                }
                //发送post信息
                LXHttpsClient.getInstacne().get(task, new LXAsyncCallback<String>() {
                    @Override
                    public void failure(Exception e, String tag) {
                        if (e instanceof LXHttpException) {
                            result.error((Integer.toString(((LXHttpException) e).getResponseCode())), e.getMessage(), e.getCause().toString());
                        } else {
                            result.error("-1", e.getMessage(), e.getCause().toString());
                        }
                    }

                    @Override
                    public void success(String data, String tag) {
                        result.success(data);
                    }
                });
            }
            //http请求
            else {
                //转换为task
                LXHttpTask task = new LXHttpTask(url, jsonToHashMap(body));
                //设置超时时间
                task.setConnectTimeOut(timeout);
                //转换为
                HashMap<String, Object> headerMap = jsonToHashMap(header);
                //装换为header
                for (String key : headerMap.keySet()) {
                    task.addRequestProperty(key, headerMap.get(key).toString());
                }
                //发送post信息
                LXHttpClient.getInstacne().get(task, new LXAsyncCallback<String>() {
                    @Override
                    public void failure(Exception e, String tag) {
                        if (e instanceof LXHttpException) {
                            result.error((Integer.toString(((LXHttpException) e).getResponseCode())), e.getMessage(), e.getCause().toString());
                        } else {
                            result.error("-1", e.getMessage(), e.getCause().toString());
                        }
                    }

                    @Override
                    public void success(String data, String tag) {
                        result.success(data);
                    }
                });
            }
        } else {
            result.notImplemented();
        }
    }

    /**
     * 将json格式的字符串转成Map对象
     */
    private static HashMap<String, Object> jsonToHashMap(String jsonStr) {
        //创建map
        HashMap<String, Object> map = new HashMap<String, Object>();
        try {
            //解析参数
            JSONObject jsonObject = new JSONObject(jsonStr);
            //遍历
            Iterator it = jsonObject.keys();
            // 遍历jsonObject数据，添加到Map对象
            while (it.hasNext()) {
                String key = String.valueOf(it.next());
                Object value = jsonObject.opt(key);
                map.put(key, value);
            }
        } catch (Exception ex) {

        }
        return map;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {


    }
}
