var firstTime = true;
var badgeColors = {grey: "", green: "badge-success", orange: "badge-warning", red: "badge-important", blue: "badge-info", black: "badge-inverse"};
var getBadgeClass = function(coins)
{
	if(coins<100)
		return badgeColors.red;
	else if(coins>=100 && coins<=130)
		return badgeColors.blue;
	else if(coins>130 && coins<=200)
		return badgeColors.green;
	else if(coins>200 && coins<=300)
		return badgeColors.orange;
	else if(coins>300 && coins<=450)
		return badgeColors.grey;
	else
		return badgeColors.black;
}

//$spanBadge: jQuery object of the span element which is the badge
//coins (string): most up-to-date number of coins
var updateBadge = function($spanBadge, coins)
{
	if(firstTime || $spanBadge.text()!==coins)
	{
		if(!firstTime)
			console.log("Update Badge to: "+coins);
		else
			console.log("First Time: Coins: "+coins+" Badge Class: "+getBadgeClass(coins));
		$spanBadge.text(coins+"");
		// console.log("Span: "+$spanBadge.html());
		$spanBadge.removeClass();
		$spanBadge.addClass("badge");
		$spanBadge.addClass(getBadgeClass(coins));
		$spanBadge.effect("highlight", {}, 3000);
	}
}

var updateVidactaCoins = function()
{
	$(".badge").each(function(){
		var $this = $(this);
		var userID = $(this).data('id');
		//console.log(userID);
		var coins = 0;
		if(firstTime)
			updateBadge($this, $this.text());
		else
		{
			//make ajax call for coins and updateBadge
			var JSONurl = "/pages/ajaxUserScore";
			$.getJSON(window.location.protocol+"//"+window.location.host + JSONurl, {id: userID}, function(json){
				//console.log("coins: "+JSON.stringify(json));
				// console.log("This object: "+$(this).parent().html());
				updateBadge($this, JSON.stringify(json));		
			});
		}		
	});
	firstTime = false;
}