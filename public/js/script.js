$(document).ready(function() {
    setTimeout(function() {
        $(".confirmacion").fadeOut(1500);
    }, 3000);

    $('#btnReset').click(function() {
        $(".content").show();
        setTimeout(function() {
            $(".confirmacion").fadeOut(1500);
        }, 3000);
    });
}); 