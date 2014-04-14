<!DOCTYPE html>
<html lang="CZ">
	<head>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				// Active camera will refresh every 1 seconds
				var TIMEOUT = 1000;
				var refreshInterval = setInterval(function() {
					$('img#camera').attr('src', 'http://localhost:8081');
				}, TIMEOUT);	
			});
		</script>
	</head>
	<body>
		<img src="" id="camera">
	</body>
</html>