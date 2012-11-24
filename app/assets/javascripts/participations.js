function progressBar(online_perc, offlice_perc){
	$('.progress .bar.bar-success').css('width', (online_perc)+'%')
	$('.progress .bar.bar-warning').css('width', (offline_perc)+'%')
}