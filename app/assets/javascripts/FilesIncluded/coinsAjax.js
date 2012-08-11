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
		return badgeColors.black;
	else if(coins>300 && coins<=450)
		return badgeColors.grey;
	else
		return badgeColors.orange;
}

//$spanBadge: jQuery object of the span element which is the badge
//coins (string): most up-to-date number of coins
var updateBadge = function($spanBadge, coins)
{
	if(firstTime || $spanBadge.text()!==coins)
	{
		if(!firstTime)
			console.log("Update Badge to: "+coins);
		$spanBadge.text(coins+"");
		// console.log("Span: "+$spanBadge.html());
		$spanBadge.removeClass();
		$spanBadge.addClass("badge");
		$spanBadge.addClass(getBadgeClass(coins));
		$spanBadge.effect("highlight", {}, 3000);
	}
}