$(document).ready(function()
  {
  $("textarea.gray, input.gray").focus(function(){$(this).attr("rows",7).filter(".gray").removeClass("gray").attr("value","")});
  });
