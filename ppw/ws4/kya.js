
$(document).ready(function(){			   
	$("form").submit( function(){
		validasi();
		return false; //prevent refresh
		
	});
	
	$("#submit").click( function(){
		$(this).animate({opacity:"0.5"},"fast");
		$(this).animate({opacity:"1"},"slow");
	});
	
	$("#reset").click( function(){
		$(this).animate({opacity:"0.5"},"fast");
		$(this).animate({opacity:"1"},"slow");
		alert("Reset success, please enter the data");
		event.preventDefault(); // not submitting the form
	});

	$("#tema").change(function(){
		$("#formnya").removeClass("white-gray");
		$("#formnya").removeClass("dark-gray");
		$("#formnya").addClass($("#tema").val());
		$("input[type='submit']").addClass("white-gray");
		$("input[type='submit']").addClass("dark-gray");
		$("input[type='submit']").removeClass($("#tema").val());
		$("input[type='reset']").addClass("white-gray");
		$("input[type='reset']").addClass("dark-gray");
		$("input[type='reset']").removeClass($("#tema").val());

	});
	
	function validasi(){
		var nama = $('input[type="text"]').val();
		var email = $('input[type="email"]').val();
		var komen = $('textarea').val();
		if (nama == ""){ 
			window.alert("Please enter your name");
			return;
		}
		if (email == ""){
			window.alert("Please enter your email");
			return;
		}
		if (komen == ""){
			window.alert("Please enter your comment");
			return;
		}
		var hasil = nama+" || "+email+"<br><br>"+komen;
		if (email.indexOf("@")<=0 || email.substring(email.indexOf("@")).indexOf(".") <= 0){
			window.alert("Invalid email");
			return;
		}
		if ($('#bold').prop('checked')){
			$('#hasil').css("font-weight","bold");

		} else
			$('#hasil').css("font-weight","normal");
		
		if ($('#italic').prop('checked')){
			$('#hasil').css("font-style","italic");

		} else
			$('#hasil').css("font-style","normal");
			
		if ($('#under').prop('checked')){
			$('#hasil').css("text-decoration","underline");
		} else
			$('#hasil').css("text-decoration","none");
		
		$('#hasil').css("color",$('#warna').val());
		$('#hasil').css("font-size",$('#fsize').val());
		$("#hasil").html(hasil);
		$("#hasil").animate({left:"+20"},"slow");
		$("#hasil").animate({height:"120px"},"slow");
	}
	
});