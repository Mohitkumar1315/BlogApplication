/*$(document).ready(function() {
    alert("This web is not safe for continue pleas press enter!");
});*/

function doLike(pid, uid) 
{
    console.log(pid + "" + uid);
    const d = {
        uid: uid,
        pid: pid,
        operation: 'like'
    };
    $.ajax({
        url: "LikeServlet",
        data: d,
        success: function(data, textStatus, jqXHR) 
        {
    	console.log(data);
    	$(".like-counter").html(data);
		},
      		error: function(jqXHR, textStatus, errorThrown) 
      		{
            console.log(errorThrown);
        	}
    });
}
