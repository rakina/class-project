
$(document).ready(function(){

	if (typeof(Storage)=="undefined"){
		$("body").html("Storage is not supported");
	}
	if (localStorage.getItem("win") !== null){
		$("#win").html(localStorage.getItem("win"));
	}
	else 
		localStorage.setItem("win","0");

	if (localStorage.getItem("lose") !== null){
		$("#lose").html(localStorage.getItem("lose"));
	}
	else 
		localStorage.setItem("lose","0");

	if (localStorage.getItem("games") !== null){
		var n = parseInt(localStorage.getItem("games"));
		//alert(n);
		for (var i = 0; i < n; ++i){
			//alert(i+" "+localStorage.getItem("score"+i));
			$("#log").append("<tr><td>"+(i+1)+"</td><td>"+localStorage.getItem("score"+i)+"</td></tr>");
		}
	}
	else
		localStorage.setItem("games","0");


	$.ajax({
		url : "listkata.txt",
		dataType: "text",

		success : function (data) {
			var lines = data.split("\n");
			for (var i = 0; i < lines.length; ++i){
				sessionStorage.setItem(lines[i],lines[i]);
			}
		}
	});

	var secretWord;
	var pertamax = true;
	var charsLeft;
	var hang = 0;

	$("#reset").click(function(){
		localStorage.setItem("games","0");
		localStorage.setItem("lose","0");
		localStorage.setItem("win","0");
		$("#win").html("0");
		$("#lose").html("0");
		$("#log").html("<tr><th> No </th><th> Score </th></tr>");
	});

	$("#play").click(function(){
		$(this).html("Play again");
		$("#keyboard").css("display","block");
		$('button').attr('disabled',false); // enabling all buttons
	    var idx = Math.floor((Math.random() * sessionStorage.length));
		secretWord = sessionStorage.key(idx);
		$("#board").html("");
		var tmp = "";
		for (var i = 0; i < secretWord.length-1; ++i)
			$("#board").append("<div class = 'underscore' id = 'u"+i+"'>&nbsp;</div>");
		charsLeft = secretWord.length-1;
		hang = 0;
		$("#hangman").attr("src","img/"+hang+".png");
		$("#score").html("0");
	});

	function updateLog(){
		 var n = parseInt(localStorage.getItem("games"));
		 localStorage.setItem("score"+n,$("#score").html());
		 localStorage.setItem("games",n+1);
		 $("#log").append("<tr><td>"+(n+1)+"</td><td>"+localStorage.getItem("score"+n)+"</td></tr>");
	}

	$("#keyboard button").click(function(){
		$(this).attr("disabled",true);
		var guess = $(this).attr("value");
		var found = false;
		
		for (var i = 0; i < secretWord.length-1; ++i){
			if (guess == secretWord.charAt(i)){
				found = true;
				charsLeft--;
				$("#u"+i).html(guess);
			}
		}
		if (!found){
			//change the image
			hang = hang + 1;
			$("#hangman").attr("src","img/"+hang+".png");
			// substract the score
			var score = parseInt($("#score").html());
			score -= 10;
			$("#score").html(score);
			if (hang == 7){
				// you lost!
				$("#keyboard").css("display","none");
				$("#board").append("<br/> <h1>YOU LOST</h1>");
				$("#board").append("<h2> it's "+secretWord.substring(0,secretWord.length-1)+"! </h2>");
				var loses = parseInt(localStorage.getItem("lose"));
				loses++;
				$("#lose").html(loses);
				localStorage.setItem("lose",loses);
				updateLog();
			}
		}
		else{
			// add the score
			var score = parseInt($("#score").html());
			score += 20;
			$("#score").html(score);

			if (charsLeft === 0){
				$("#keyboard").css("display","none");
				$("#board").append("<br/> <h1>YOU WON</h1>");
				$("#board").append("<h2> it's "+secretWord.substring(0,secretWord.length-1)+"! </h2>");
				var wins = parseInt(localStorage.getItem("win"));
				wins++;
				$("#win").html(wins);
				localStorage.setItem("win",wins);
				updateLog();
			}
		}

	});


});