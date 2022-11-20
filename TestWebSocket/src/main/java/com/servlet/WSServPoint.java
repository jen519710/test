package com.servlet;

import java.io.IOException;
import java.net.URLDecoder;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.apache.commons.lang3.ArrayUtils;

import com.alibaba.fastjson.JSONObject;

@ServerEndpoint(value = "/chatroom")
public class WSServPoint {
	static Set<Session> set = new HashSet<Session>();
	private Map<String, String> map;
//私訊12.13看
	private Message ms;
	static List<String> userList = new ArrayList<String>();// 收集用戶訊息

	@OnOpen
	public void onOpen(Session session) throws IOException {
		System.out.println("@OnOpen");
		String p = session.getQueryString();// 從前台傳訊息回來
		p = URLDecoder.decode(p, "UTF-8");
		map = new HashMap<String, String>();// 儲存前台傳回資訊

		if (p.contains("&")) {// 判斷資訊
			String[] tokens = p.split("\\&");
			for (String s : tokens) {
				String[] strs = s.split("=");
				map.put(strs[0], strs[1]);
			}
		} else {
			String[] strs = p.split("=");
			map.put(strs[0], strs[1]);
		}

		System.out.println("map:" + map);
		ms = new Message();// 儲存傳回訊息資訊(上限系統訊息)
		ms.setType("system");
		ms.setMsgSender("system");
		ms.setMsgdate(new Date());
		

		userList.add(map.get("user"));
		ms.setUserList(userList);
		set.add(session);

		ms.setMsgInfo(map.get("user") + "已上線");

		String jsonstr = JSONObject.toJSONString(ms);
		bordcast(set, jsonstr);
	}

	@OnClose
	public void onClose(Session session) throws IOException {
		System.out.println("@OnClose");
		userList.remove(map.get("user"));
		ms = new Message();//下線系統訊息
		ms.setType("system");
		ms.setMsgSender("system");
		ms.setMsgdate(new Date());
		ms.setUserList(userList);
		ms.setMsgInfo(map.get("user") + "已下線");
		set.remove(session);
		String jsonstr = JSONObject.toJSONString(ms);
		bordcast(set, jsonstr);
	}

	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		System.out.println("@OnMessage" + message);
		ms = new Message();//傳的訊息
		ms.setType("people");
		ms.setMsgSender(map.get("user"));
		ms.setMsgdate(new Date());
		ms.setMsgInfo(message);
		
		String jsonstr = JSONObject.toJSONString(ms);// 回傳訊息轉json
		System.out.println(jsonstr);
		bordcast(set, jsonstr);
	}

	@OnError
	public void onError(Throwable t) throws Throwable {
		System.out.println("@OnError");
	}

	public void bordcast(Set<Session> set, String message) throws IOException {
		for (Session s : set) {
			s.getBasicRemote().sendText(message);// 將訊息傳至前台

		}
	}
	
	private byte[] wholePic=null;
	@OnMessage//圖片
	public void onImg(byte[] input, Session session,boolean flag) throws IOException  {
		//flag 判斷圖片檔是否接收完全 false 有檔案沒接收完
		if(!flag) {
			System.out.println(input.length+"  "+flag);
			wholePic=ArrayUtils.addAll(wholePic, input);
			//將每次慈讀取的byte[] input，塞入wholePic

		}else {
			System.out.println(input.length+"  "+flag+"nnnnnnnnn");
			wholePic=ArrayUtils.addAll(wholePic, input);
			ByteBuffer bb = ByteBuffer.wrap(wholePic);//把byte[]轉乘ByteBuffer
			bordcast(set,bb);
			wholePic=null;
			Message ms=new Message();
			ms.setMsgSender(map.get("user"));
			ms.setMsgdate(new Date());
			ms.setType("img");
			String jsonstr = JSONObject.toJSONString(ms);// 回傳訊息轉json
			System.out.println(jsonstr);
			bordcast(set, jsonstr);
		}
	}
	public void bordcast(Set<Session> set, ByteBuffer input) throws IOException {
		for (Session s : set) {
			s.getBasicRemote().sendBinary(input);// 將圖片傳至前台
		}
	
	}
}
