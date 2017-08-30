//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2013 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

dojo.ready(function(){
	
	_on = require("dojo/on");
	
	windowResizeHandleFooter = function() {
		var myWinWidth = viewport().width;
		var footer = dojo.byId("footer");
		var footerCMS = dojo.byId("footerCMSContent");
		var headerRow2 = dojo.byId("headerRow2");
		
		if(myWinWidth >= desktopBreakpoint) {
			dojo.place(footerCMS, footer, "last");
		} else {
			dojo.place(footerCMS, headerRow2, "last");
		}
		
	};
	
	_on(window, "resize", function() {
		windowResizeHandleFooter();
	});
	
	$('#subscribeNewsletter > input[name="email"]').keyup(function(){
		var email = $('#subscribeNewsletter > input[name="email"]');
		var submit = $('#submitNewsletter');
		if(email != ''){
			submit.removeAttr('disabled');
		}
		else{
			submit.attr('disabled','disabled');
		}
	});
	
	windowResizeHandleFooter();
});

/**
 * Method to subscribe
 * 
 */
function subscribeNewsletter(form){
	if(!isSubmited) {
		$("#subscribeNewsletterErrorMessageArea p").hide();
		$('#subscribeNewsLetterPopup').hide();

		isSubmited = true;
		$.ajax({
			url : $('#'+form.id).attr('action'),
			type : 'POST',
			data : $('#'+form.id).serializeArray(),
			success : function(response, statut) {
				isSubmited = false;
				if(response.status == 'OK'){
					$('#newsletterField').hide();
					$('#subscribeNewsLetterPopup_cancel').hide();
					$('#submitNewsletter').hide();

					$('#submitNewsletterClose').show();
					$('#subscribeNewsLetterPopupOK').show();
				} else{
					if(response.status == 'KO'){
						$('#subscribeNewsLetterPopupKO').show();
					} else {
						$('#subscribeNewsLetterPopupKOTech').show();
					}
				}
				$('#subscribeNewsLetterPopup').show();
			},
			error : function(xhr, desc, err) {
				isSubmited = false;
				$('#subscribeNewsLetterPopupKOTech').show();
				$('subscribeNewsLetterPopup').show();
			}
	 	});
	}
}

var isSubmited = false;

$(document).ready(function() {

	$("#footerCMSContent .footer-header").on("click", function(){
		var myWinWidth = viewport().width;
		var picto = $(".plusMinusWhitePicto", $(this));
		if(myWinWidth < desktopBreakpoint && picto != null && picto[0] != null){
			if(picto[0].className.search("plusWhitePicto") != -1){
				picto.addClass("minusWhitePicto").removeClass("plusWhitePicto");
			} else {
				picto.addClass("plusWhitePicto").removeClass("minusWhitePicto");
			}
			
			var footerListCms = $(this).parent().find(".footer-list-cms");
			footerListCms.slideToggle();
		}
	});
});
