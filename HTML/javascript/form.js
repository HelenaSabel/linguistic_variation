
function formulario() {
    var inputs = document.querySelectorAll('input[type="radio"]');
    for (var i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener('click', giveID, false);
    }
}

function giveID() {
    var id = this.getAttribute('value');
    var ams = document.getElementsByClassName('am');
    var expans = document.getElementsByClassName('expansion');
    var regs = document.getElementsByClassName('reg');
    var origs = document.getElementsByClassName('orig');
    
    switch (id) {
        
        case 'abb':
        for (var i = 0; i < ams.length; i++) {
            ams[i].style.display = 'inline-block';
        }
        for (var i = 0; i < expans.length; i++) {
            expans[i].style.display = 'none';
        }
        
        break;
        
        case 'expan':
        for (var i = 0; i < ams.length; i++) {
            ams[i].style.display = 'none';
        }
        for (var i = 0; i < expans.length; i++) {
            expans[i].style.display = 'inline-block';
        }
        
        break;
        
        case 'reg':
        for (var i = 0; i < regs.length; i++) {
            regs[i].style.display = 'inline-block';
        }
        for (var i = 0; i < origs.length; i++) {
            origs[i].style.display = 'none';
        }
        
        break;
        
        case 'orig':
        for (var i = 0; i < regs.length; i++) {
            regs[i].style.display = 'none';
        }
        for (var i = 0; i < origs.length; i++) {
            origs[i].style.display = 'inline-block';
        }
        
    }
}

window.addEventListener('load', formulario, false);