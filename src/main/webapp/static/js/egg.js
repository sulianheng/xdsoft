$(".eggList li").click(function() {
	$(this).children("span").hide();
	if ($(this).hasClass("curr")) {
		alert("蛋都碎了，别砸了！明天再来.");
		return false;
	}
	var elements = document.getElementsByTagName("li");
	for (var j = 0; j < elements.length; j++) {
		if ($(elements.item(j)).hasClass("curr")) {
			alert("今日已经砸过蛋了，蛋蛋会忧伤，明天再来哦");
			return false;
		}
	}
	
	$.get("roborder/robing", function(data) {
		$("#result").show().html(data.count + "<script>$('#div').fadeIn();</script>");
	});
	$(".hammer").css({
		"top" : $(this).position().top + 25
	});
	$(this).addClass("curr");
});

$(".eggList li").hover(function() {
	var posL = $(this).position().left + $(this).width();
	$("#hammer").show().css('left', posL);
})