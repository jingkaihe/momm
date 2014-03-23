jQuery(function(){
  var load_exchanged = function(){
    $.get($('.momm').data('url'), {
      from: $('.momm-from').val(),
      to: $('.momm-to').val(),
      money: $('.momm-money').val(),
      date: $('.momm-date').val()
    }, function(result){
      console.log(result);
      $('.momm-exchange').text(result);
    });
  };

  var today = new Date();
  var prettyDate =today.getFullYear() + '-' + (today.getMonth()+1) + '-' + today.getDate();
  $(".momm-date").datepicker({ dateFormat: 'yy-mm-dd' });
  $(".momm-date").val(prettyDate);

  load_exchanged();

  $(".mom-ele").on('change', load_exchanged);
});