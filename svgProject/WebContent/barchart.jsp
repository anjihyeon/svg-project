<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
@font-face { font-family: 'Eoe_Zno_L'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_eight@1.0/Eoe_Zno_L.woff') format('woff'); font-weight: normal; font-style: normal; }
body{
	font-family: 'Eoe_Zno_L';
	display: block;
}
ul{
   list-style:none;
}
#svg:hover,
#svg:focus {
  .bar {
    fill: #aaa;
  }
}
#bar:hover,
#bar:focus {
  fill: #FE9A2E !important;
  
  text {
    fill: #FE9A2E;
  }
}
#section{
	width: 400px;
	height: 200px; 
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	inputChart();//엑셀파일을 받는다. 단.키와 값으로 된 엑셀만 차트로 만들 수 있다.
})
function drawBarChart(data){ //엑셀파일 받은 후 데이터 차트로 만듬.
	var csvData = new Array();
	var object =data;
	//엑셀 제목을 빼기 위한 i=1
	for (var i = 1; i < object.length; i++) {
	  if(object[i]!="") //빈공백확인
		csvData.push(object[i].split(','));
	}
	console.log(csvData);
	var svg = document.createElementNS("http://www.w3.org/2000/svg","svg");
	svg.setAttribute("id", "svg");
	svg.setAttribute("width", 500);
	svg.setAttribute("height", 500);
	svg.setAttribute("style", "margin-top:20;margin-right: 20;margin-bottom: 20;margin-left: 20;");
	$("#chart").append(svg);
	for(var i=0;i<csvData.length;i++){
		var g = document.createElementNS("http://www.w3.org/2000/svg","g");
		g.setAttribute("id","bar");
		var text = document.createElementNS("http://www.w3.org/2000/svg","text");
		text.setAttribute("id","text");
		text.setAttribute("y",i*20);
		text.setAttribute("x",10);
		text.setAttribute("dx","300px");
		text.setAttribute("dy","100px");
		text.setAttribute("style", "padding-top:20;padding-right: 20;padding-bottom: 20;padding-left: 20;");
		text.textContent = csvData[i][0];
		var rect = document.createElementNS("http://www.w3.org/2000/svg","rect");
		rect.setAttribute("id","rect");
		rect.setAttribute("width", 19);
		rect.setAttribute("height",(csvData[i][1]*10));
		rect.setAttribute("x",(20*i));
		rect.setAttribute("y",500-csvData[i][1]);
		g.append(rect);
		g.append(text);
		svg.append(g);	
	}
	sectionChart();
}
function inputChart(){ //엑셀받을 input
	var inputCsv = document.createElement("input");
	inputCsv.setAttribute("type","file");
	inputCsv.setAttribute("accept",".csv");
	inputCsv.setAttribute("onchange","loadFile(this)");
	inputCsv.setAttribute("onclick","removeChart(this)");
	$("#input").append(inputCsv);
}
function loadFile(sender){ //파일 읽기
    var validExts = new Array(".csv"); 
    var fileExt = sender.value;
    fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
 
    if (fileExt && validExts.indexOf(fileExt) < 0) {
    	//.csv파일이 아닌 경우
        alert("Invalid file selected. valid files are of .csv types. ");
        return false;
    }
    var reader = new FileReader();
    reader.onload = function (d) {
        var data = reader.result;	
        if (fileExt === ".csv") {
            data = data.split(/\r\n|\n/);  // 줄바꿈으로 나눔
            console.log(data);
            drawBarChart(data);
        }
    };
    reader.readAsText(sender.files[0]);
}
function removeChart(d){
	var svg = document.getElementById('svg');
	if(svg!=null){
		svg.remove();
		$("#rectC").val('');
	}
}
function sectionChart(){//차트의 속성 변경
	var svgWdata = document.getElementById('svg').getAttribute('width');
	var svgW = document.getElementById('svgW').setAttribute('value',svgWdata);
	var svgHdata = document.getElementById('svg').getAttribute('height');
	var svgH = document.getElementById('svgH').setAttribute('value',svgWdata);
	var rectCdata = document.getElementById('rect').getAttribute('fill');
	var rectC = document.getElementById('rectC').setAttribute('value',rectCdata);
}
function svgWchange(d){
	var svg = document.getElementById("svg");
	svg.setAttribute("width",d);
}
function svgHchange(d){
	var svg = document.getElementById("svg");
	svg.setAttribute("height",d);
}
function rectChange(d){
	var rect = document.querySelectorAll("rect");
	console.log(rect);
	for(var i in rect){
		rect[i].setAttribute("fill",d);							
	}
}
</script>
<meta charset="UTF-8">
<title>BarChart</title>
</head>
<body>
<div id="chart">
</div>
<div id="input">
</div>
<div id="section">
<section>
	<h3>차트 설정</h3>
	<fieldset>
		<ul>
			<li>
				<label><strong>svg 너비</strong></label>
				<input type="text" id="svgW" value="" onchange="svgWchange(this.value)">
			</li> 
			<li>
				<label><strong>svg 높이</strong></label>
				<input type="text" id="svgH" value="" onchange="svgHchange(this.value)">
			</li> 
			<li>
				<label><strong>색상변경</strong></label>
				<input type="text" id="rectC" value="" onchange="rectChange(this.value)">
			</li> 
		</ul>
	</fieldset>
</section>
</div>
</body>
</html>