// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails


//= require jquery
//= require jquery_ujs
import "@hotwired/turbo-rails"
import "controllers"

$(function(){
    $(document.body).on('click', '#generate', function(e){
      var cells = [];
      $('.live').each(function(){
        var col = parseInt($(this).attr('col'));
        var row = parseInt($(this).attr('row'));
        cells.push([col,row]);
      });
        
       
      $.post('/generate', {cells: cells});

      var count_gen = parseInt( $('h1').attr('count-gen') ) + 1;

      $('h1').attr('count-gen',count_gen);
      $('h1 span').text(count_gen);
        
    });

    $(document.body).on('click', '#clear', function(){
      $.post('/clear', {});
      $('h1').attr('count-gen',1);
      $('h1 span').text(1);
    });
  });
