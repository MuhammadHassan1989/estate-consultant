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
    
    $( ".link-delete-building" ).click( function( e ) {
        e.preventDefault();
        
        var link = $( this );
        var name = link.siblings( ".building-name" ).text();
        $.confirm({
            content: "确定要删除 " + name + " 的所有数据吗？",
            callback: function( yes ) {
                if ( !yes ) {
                    return;
                }
                
                link.parents( ".building" )
                    .fadeOut( "fast", function() {
                        $( this ).remove();
                    });
            }
        });
    });
    
});

})( jQuery );