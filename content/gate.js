var addRows = function (rows) {
  if (rows != null || rows.length > 0) {
    //   console.table(rows);
    var $tbody = $("table.log-table > tbody");
    $tbody.html("");
    for (var i = 0; i < rows.length; i++) {
      var $tr = $("<tr>").data("id", rows[i].id);
      $tr.append("<td>" + rows[i].personName + "</td>");
      $tr.append("<td>" + rows[i].buildingName + "</td>");
      $tr.append("<td>" + rows[i].controlPointName + "</td>");
      $tr.append("<td>" + rows[i].accessDateTime + "</td>");
      $tr.appendTo($tbody);
    }
  }
};

var actionAddTestRecord = function () {
  $.ajax({
    url: "../api/add-random-log-on-this-day.asp",
    success: function (x) {
      console.log(x);
      showLogs();
    },
  });
};

var showLogs = function () {
  $.ajax({
    url: "../api/get-last-logs.asp",
    success: function (x) {
      addRows(x.data);
    },
  });
};

$(function () {
  showLogs();
  $(".action-add-test-record").on("click", function (e) {
    e.preventDefault();
    actionAddTestRecord();
  });
});
