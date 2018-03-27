
function changeAds(id) {
    $('#adss-'+id+' .price-normal').hide();
    $('#adss-'+id+' .price-cheap').show();
    $('#adss-'+id+' #cupon').fadeIn(300);
}

function changeBackAds(id) {
    $('#adss-'+id+' .price-normal').show();
    $('#adss-'+id+' .price-cheap').hide();
    $('#adss-'+id+' #cupon').hide();
}