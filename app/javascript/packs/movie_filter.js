
$(document).ready(function Movie_filter() {
  $("#G_filter").click(function () {
      if ($(this).is(":checked")) {
        $('tr.G').show();
      } else {
        $('tr.G').hide();
      }
  });
  $("#PG_filter").click(function () {
    if ($(this).is(":checked")) {
      $('tr.PG').show();
    } else {
      $('tr.PG').hide();
    }
  });
  $("#PG-13_filter").click(function () {
    if ($(this).is(":checked")) {
      $('tr.PG-13').show();
    } else {
      $('tr.PG-13').hide();
    }
  });
  $("#R_filter").click(function () {
    if ($(this).is(":checked")) {
      $('tr.R').show();
    } else {
      $('tr.R').hide();
    }
  });
  $("#NC-17_filter").click(function () {
    if ($(this).is(":checked")) {
      $('tr.NC-17').show();
    } else {
      $('tr.NC-17').hide();
    }
  });
  $("-_filter").click(function () {
    if ($(this).is(":checked")) {
      $('tr.-').show();
    } else {
      $('tr.-').hide();
    }
  });
})