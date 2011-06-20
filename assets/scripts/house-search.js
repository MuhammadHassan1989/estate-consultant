( function( $ ) {

$( function() {
    var defaultText = $( "#txt-search" ).val();
    $( "#txt-search" ).focus( function( e ) {
        if ( $( this ).val() == defaultText ) {
            $( this ).val( "" );
        }
        $( this ).addClass( "active" );
    }).blur( function( e ) {
        if ( $( this ).val() == "" ) {
            $( this ).val( defaultText );
            $( this ).removeClass( "active" );
        }
    });
});

})( jQuery );