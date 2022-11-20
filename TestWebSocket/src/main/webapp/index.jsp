<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
<fieldset>
<legend>
login
</legend>
<form action="/TestWebSocket/Login" method="post">
<table>
<tr>
<td>帳號</td><td><input type="text" name="userName" size="20"></td>
</tr>
<td>密碼</td><td><input type="text" name="userPwd" size="20"></td>
</tr>
<tr>
<td colspan="2"><input type="submit" value="submit"></td>
</tr>
</table>
</form>
</fieldset>

</div>
</body>
</html>