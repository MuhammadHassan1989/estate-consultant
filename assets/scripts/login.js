( function( $ ) {

$( function() {
    var defaultEmail = $( "#txt-email" ).val();
    $( "#txt-email" ).focus( function( e ) {
        if ( $( this ).val() == defaultEmail ) {
            $( this ).val( "" );
        }
        $( this ).addClass( "input-text-active" );
    }).blur( function( e ) {
        if ( $( this ).val() == "" ) {
            $( this ).val( defaultEmail );
            $( this ).removeClass( "input-text-active" );
        }
    });
    
    var defaultPassword = $( "#txt-password" ).val();
    $( "#txt-password" ).focus( function( e ) {
        if ( $( this ).val() == defaultPassword ) {
            $( this ).val( "" );
        }
        $( this ).addClass( "input-text-active" )
            .prop( "type", "password");
    }).blur( function( e ) {
        if ( $( this ).val() == "" ) {
            $( this ).val( defaultPassword );
            $( this ).removeClass( "input-text-active" )
                .prop( "type", "text");
        }
    });
    
});

})( jQuery );