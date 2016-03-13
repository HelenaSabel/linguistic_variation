
function first() {
    var select = document.getElementsByClassName('show');
    for (var i = 0; i < select.length; i++) {
        select[i].addEventListener('click', show, false);
    }
}

function show() {
   this.parentNode.querySelectorAll('ul')[0].classList.remove('hide');
}


 window.addEventListener('load',first,false);