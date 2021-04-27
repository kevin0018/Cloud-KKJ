jQuery('document').ready(function($){
/*Con este script lo que logramos es que se muestre o se oculte el menu */    

    var menuBtn = $('.menu-icon'),
        menu = $('.navigation ul');
    
    menuBtn.click(function() {

        if ( menu.hasClass('show') ) {

            menu.removeClass('show');
        } else {

            menu.addClass('show');
        }       

    });
});