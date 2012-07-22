function checkPostForm()
{
	var question = document.getElementsByName("question")[0];
	if (question.value == "" )
	{
		alert("Please submit a post or question");
		return false;
	}
	if(document.categoryPost.category.value === "nothing")
	{
		alert("Please select a category");
		return false;
	}
	else
	{
		f.submit();
		return true;
	}
}
$(document).ready(function(){
	
		//[{"question":{"id":26,"question":"testing schedule popup","asker":{"fullName":"Arzav Jain","id":1}}}
		//,{"question":{"id":31,"question":"asdfasdf","asker":{"fullName":"Arzav Jain","id":1}}}]
		var defaultHeight = $(document).height() - $("header").height() - $("#tiny-footer").height();
		var updateListHeight = function()
		{
				var tabPaneHeight = $("div.tab-content").height();
				//alert(tabPaneHeight+" vs "+ defaultHeight);
				if(tabPaneHeight>defaultHeight-200)
					$(".tabs-left .nav-tabs").animate({height: (1.07*tabPaneHeight)+"px"}, 300);
		}
	
		var questionIsNew = function(question)
		{
				return ($("div:contains('" + question + "')").length()===0);
		}
		var addNewQuestions = function(json)
		{
				var textLines = " a conversation with ";
				for(var i in json)
				{
						var obj = json[i];
						var asker = obj.question.asker;
						if(questionIsNew(obj.question.question))
						{
								var newDiv = $("<div />").css("font-weight", "bold");
								newDiv.text(obj.question.question);
								var li = newDiv.wrap("<li />").parent();
								li.css("margin-top", "1%");
								var button = $("<button class='btn' data-toggle='modal' data-target='#schedule-modal' href = '#schedule-modal'/>");
								button.click(function(){
									addQID(obj.question.id);
								});
								button.text("Schedule");
								if(<%=current_account.id%> == asker.id)
									button.attr("disabled", "disabled");
								var a = $("<a />", {href: "/profiles?id="+asker.id}).addClass("username").html(asker.fullName);
								li.append(newDiv).append(button).append(textLines).append(a);
								//$("div#tab"+categoryID+" > ul.nav").append(li).append($("<li class='divider' />"));
								li.hide().appendTo($("div#tab"+categoryID+" > ul.nav")).fadeIn("fast");
								$("<li class='divider' />").hide().appendTo($("div#tab"+categoryID+" > ul.nav")).fadeIn("fast");
								updateListHeight();
						}
				}
		}
		
		var removeOldQuestions = function(json)
		{
				$("ul.nav-list > li > div").each(function(){
					for(var i in json)
					{
							var question = json[i].question.question;
							if($.trim($(this).text()) === question)
							{
									($(this).parent()).next().fadeOut("fast");
									$(this).parent().fadeOut("fast");
									break;
							}
					}
				});
		}
		
		var updateCategory = function()
		{
				var JSONurl = "pages/ajaxQuestion";
				var categoryID = $("li.active > a").attr("href").replace(/#tab/, "");
				$.getJSON(JSONurl, {"category": categoryID}, function(json){
							//alert(JSON.stringify(json));
							addNewQuestions(json);
							removeOldQuestions(json);
				});				
		}
		setInterval(updateCategory, 4000);
});