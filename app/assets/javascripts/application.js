// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks


//= require bootstrap-sprockets
//= require metisMenu/jquery.metisMenu.js
//= require pace/pace.min.js
//= require slimscroll/jquery.slimscroll.min.js
//= require dataTables/datatables.min.js
//= require dataTables/dataTables.checkboxes.min.js
//= require pdfmake/pdfmake.min.js
//= require pdfmake/vfs_fonts.js
//= require jszip/jszip.min.js
//= require multiselect/multiselect.min.js

//= require peity/jquery.peity.min.js

//= require inspinia.js

//= require fullcalendar/moment.min.js
//= require fullcalendar/fullcalendar.min.js
//= require fullcalendar/sk.js

//= require_tree .


function prettyDate(dd) {
var monthNames = [
  "Január", "Február", "Marec",
  "Apríl", "Máj", "Jún", "Júl",
  "August", "September", "Október",
  "November", "December"
];

var date = new Date(dd);

var day = date.getDate();
var monthIndex = date.getMonth();
var year = date.getFullYear();
var hour = date.getHours();
var minute = date.getMinutes();

if (hour < 10)  hour = '0'+hour;
if (minute < 10)  minute = '0'+minute;

if (dd !== null )

return(day + ' ' + monthNames[monthIndex] + ' ' + year +'  '+ hour+':'+minute);

else return 'Neexistuje';

}

function getTrueFalseIcon(data) {
	if (data==true) {$res = '<i class="fa fa-check-square-o fa-2x" aria-hidden="true"></i>';}
	else if(data==false)	{$res = '<i class="fa fa-window-close-o fa-2x" aria-hidden="true"></i>';}
	else {$res = 'Nezistené';}

	return $res;
}

document.addEventListener("turbolinks:load", function() {
  $('#side-menu').metisMenu({toggle: false });
});
