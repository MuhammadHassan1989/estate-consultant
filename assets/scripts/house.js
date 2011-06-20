( function( $ ) {

$( function() {
    $( ".switch-link, .switch-list" ).hover(
        function() {
            $( ".switch-link" ).addClass( "switch-link-active" );
            $( ".switch-list" ).addClass( "switch-list-active" );
        },
        function() {
            $( ".switch-link" ).removeClass( "switch-link-active" );
            $( ".switch-list" ).removeClass( "switch-list-active" );
        }
    );
    
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
    
    $( ".building-title" ).hover(
        function() {
            $( this ).addClass( "building-title-over" );
        },
        function() {
            $( this ).removeClass( "building-title-over" );
        }
    );
    
});

})( jQuery );