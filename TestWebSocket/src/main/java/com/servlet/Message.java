package com.servlet;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class Message {
	private String type;
	private List<String> userList;//儲存user信息
	private String msgSender;
	private String msgReceive;
	private String msgInfo;
	private Date msgdate;
	private String msgDateStr;//date自記設定的格式
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<String> getUserList() {
		return userList;
	}

	public void setUserList(List<String> userList) {
		this.userList = userList;
	}

	

	public String getMsgSender() {
		return msgSender;
	}

	public void setMsgSender(String msgSender) {
		this.msgSender = msgSender;
	}

	public String getMsgReceive() {
		return msgReceive;
	}

	public void setMsgReceive(String msgReceive) {
		this.msgReceive = msgReceive;
	}

	public String getMsgInfo() {
		return msgInfo;
	}

	public void setMsgInfo(String msgInfo) {
		this.msgInfo = msgInfo;
	}

	public Date getMsgdate() {
		return msgdate;
	}

	public void setMsgdate(Date msgdate) {
		this.msgdate = msgdate;
	}

	public String getMsgDateStr() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		msgDateStr = sdf.format(msgdate);
		return msgDateStr;
	}

	public void setMsgDateStr(String msgDateStr) {
		this.msgDateStr = msgDateStr;
	}
}

