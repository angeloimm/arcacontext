var stompClient = null;
function stompConnect(notificationTmpl) 
{
	var socket = new SockJS('/comm-svr');
	stompClient = Stomp.over(socket);
	stompClient.connect({userId:"customUserId"}, function (frame) {
	        debug('Connected: ' + frame);
	        stompClient.subscribe('/topic/connect', function (data) {
	            var theData = JSON.parse(data.body);
	            var notificationCounter = $("#notificationCounter").html();
	            if( notificationCounter && notificationCounter !== '' )
	            {
	            	notificationCounter = parseInt(notificationCounter)+1;
	            }
	            else
	            {
	            	notificationCounter = 1;
	            }
	            $("#liDefaultMessage").remove();
	            $("#notificationCounter").html(notificationCounter);
	            $("#notificationList").append(notificationTmpl(theData.payload[0]));
	        });
	    });
}
function stompDisconnect() 
{
    if (stompClient != null) 
    {
        stompClient.disconnect();
        debug("Client disconnesso");
    }
}