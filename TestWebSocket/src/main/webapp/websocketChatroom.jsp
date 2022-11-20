<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
	integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
	
</script>

</head>
<body>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
	<table style="border: 1px solid black;">
		<tbody>
			<tr>
				<td colspan="2" align="center">
					<h3>welcome,${sessionScope.userName}</h3>
				</td>

			</tr>
			<tr>
				<td width="500px" height="300px"
					style="border: 1px solid black; vertical-align: top;"
					name="content">
					<div style="background-color: white;">
						<table id="tbRecord">
							<tbody id="record"
								style="display: block; height: 300px; overflow: auto;overflow-x:hidden;overflow-y:auto;">



							</tbody>
						</table>
					</div>

				</td>
				<td width="100px" height="300px"
					style="border: 1px solid black; vertical-align: top;">
					<div style="overflow: auto;">
						<table id="tbuserList">
							<tbody id="userList"
								style="display: block; height: 300px; overflow: auto;"></tbody>
						</table>
					</div>

				</td>
			</tr>

		</tbody>

	</table>


	<div class="container">
		<div id="log"></div>
		<div style="align-items: center;">
			<form id="form">
				<input type="text" id="msg" name="msg" size="64" autofocus /> <input
					type="button" id="btn" value="Send" />
				<div>
					<input type="file" class="img" multiple="multiple"> <input
						type="button" value="上傳圖片" class="uploadPic">
				</div>
			</form>

		</div>
	</div>
	<script>
		let ws;
		let ws_url = "ws://localhost:8080/TestWebSocket/chatroom";

		$(function() {
			ws_connect();
			$("#btn").click(function() {

				wsSendMsg();
			})
			$(".uploadPic").click(function() {
				wsSendImg();
			})
		});
		function ws_connect() {
			let user = "${ sessionScope.userName}";
			if ('WebSocket' in window) {
				ws = new WebSocket(ws_url + "?user=" + user);
			} else if ('MozWebSocket' in window) {
				ws = new MozWebSocket(ws_url + "?user=" + user);
			} else {
				console.log('Error: WebSocket is not supported by this browser.');
				return;
			}

			ws.onopen = function() {
				console.log('Info: WebSocket connection opened.');

			};

			ws.onclose = function() {
				console.log('Info: WebSocket closed.');
			};

			ws.onmessage = function(message) {
				console.log(message.data);
				if ((typeof message.data) == "string") {
					let receive = message.data;//取訊息
					let jsonObj = JSON.parse(receive);//json轉回字串
					let type = jsonObj.type
// 					console.log(jsonObj.msgType + "11111");
// 					console.log(jsonObj.msgSender + "   sender")
					if (type == "system") {
						$('#userList').append(
								"<div>" + jsonObj.msgInfo + "</div>")
					}
					// 判斷是否為本人的訊息
					if (user == jsonObj.msgSender && type == "people") {
						$("#record").append(
								"<div style='width:500px'><div class='me'style='text-align:right'>"
										+ jsonObj.msgSender + "<br>"+ jsonObj.msgInfo + "</div></div>");
					} else if (user != jsonObj.msgSender && type == "people") {
						$("#record").append(
								"<div>" + jsonObj.msgSender + "</div><div>"
										+ jsonObj.msgInfo + "</div>");
					}
					if(user == jsonObj.msgSender && type == "img"){
						showPic="<div  style='width:500px;border:1px solid black'><div style='text-align:right'>" + jsonObj.msgSender + "</div>";
						picPosition="text-align:right";
						console.log(picPosition);
										
					}else if (user != jsonObj.msgSender &&  type == "img"){
						showPic="<div  style='width:500px;border:1px solid black'><div>" + jsonObj.msgSender + "</div>";
						picPosition="";
						console.log(picPosition);
					}
// 					console.log(message.data);
				} else {
					console.log(message.data)
					let reader = new FileReader();
					reader.readAsDataURL(message.data);
					//读取指定的 Blob 或 File，
					//读取操作完成的时候，readyState 会变成已完成DONE
					// result 属性将包含一个data:URL 格式的字符串（base64 编码）以表示所读取文件的内容
					reader.onload=function(event){
					
						if(event.target.readyState==FileReader.DONE){
						//FileReader.readyState 表示目前 FileReader 狀態	
						//EMPTY		0	尚未讀入任何資料。
						//LOADING	1	正在讀入資料。
						//DONE		2	完成資料讀取。
						
							let url=event.target.result;
							showPic=showPic+"<div style='"+picPosition+"'><img src="+url+" style='width:150px;'></div></div>";
							console.log(showPic);
							$("#record").append(showPic);
						}
					}
				}

			};
		}
		function wsSendMsg() {
			let msg = $("#msg").val();
			ws.send(msg);//訊息送到後端
			msg = $("#msg").val("");
		}

		function wsSendImg() {
			let img = $(".img")[0].files[0];//拿到圖片檔  
			if (img) {
				let reader = new FileReader();
				reader.readAsArrayBuffer(img);//.readAsArrayBuffer(img)讀取圖片檔
				// result 属性中将包含一个 ArrayBuffer 对象以表示所读取文件的数据
				reader.onload = function(event) {
					console.log(event.target.result);
					ws.send(event.target.result);//圖片傳到後端
					//FileReader.result 讀入的資料內容。只有在讀取完成之後此屬性才有效，
					//而資料的格式則取決於是由哪一個方法進行讀取。
				}
				$(".img").val("");

			} else {
				$(".img").val("");
			}
		}
	</script>
</body>
</html>