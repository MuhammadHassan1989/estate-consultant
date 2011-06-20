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
    
});

})( jQuery );