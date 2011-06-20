( function( $ ) {

$( function() {
    $( ".house-table tr" ).hover(
        function() {
            $( this ).addClass( "over" );
        },
        function() {
            $( this ).removeClass( "over" );
        }
    );
});

})( jQuery );