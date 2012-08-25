// Attempt to stop auto-play on YouTube videos - currently broken

var player = $('#movie_player');

if (!player) return;

player.attr('flashvars', "autoplay=0&" + player.attr('flashvars'));
player.attr('src', player.attr('src') + "#");
