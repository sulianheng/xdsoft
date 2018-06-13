(function($){
	$(function(){
		$('[data-toggle="popover"]').popover();
		
		/**
		$('img').load(function(){
			$(".masonry").masonry({
				itemSelector: '.col-md-4'
			});
		});*/
		
		var $masonry = $('.masonry');
		$masonry.imagesLoaded(function(){
			$masonry.masonry({
				itemSelector: '.col-md-4'
			});
		});
		
		/**
		 * 点赞事件
		 */
		$("#articles").on('click', '.like-btn', function(){
			$.post($(this).attr('href'),{}, function(context){
				return function( result ){
					if( result == 1){
						var $liked = $(context).prev("span.liked-sum");
						$liked.text($liked.text() - 0 + 1);
					}else{
						
					}
				};
			}(this));
			return false;
		});
	});
})(jQuery);