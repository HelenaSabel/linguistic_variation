"use strict";

function criteria() {
    var show = document.getElementsByClassName('dinamic')[0];
    show.addEventListener('mouseover', popUp, false);
}


function popUp(event) {
    if (! this.id) {
        var criterion = document.createElement("div");
        var div = document.getElementsByClassName('criterios')[0];
        var divContent = div.cloneNode(true);
        var y = event.pageY;
        var random = "n" + Math.random();
        this.id = random;
        if (this.dataset.exp) {
            criterion.innerHTML = this.dataset.exp;
        }
        criterion.appendChild(divContent);
        criterion.classList.add('popup');
        criterion.style.fontSize = "smaller";
        criterion.style.backgroundColor = "#EFEEA9";
        criterion.style.position = "absolute";
        criterion.style.top = (y - 125) + "px";
        criterion.style.right = "19%";
        criterion.style.border = "1px solid #2B3966";
        criterion.style.borderWidth = "2px";
        criterion.style.color = "#3D2301";
        criterion.style.margin = "0";
        criterion.style.padding = ".5em";
        criterion.dataset.pointer = random;
        criterion.addEventListener('mouseleave', destroy, false);
        window.addEventListener('scroll', destroy, false);
        document.body.appendChild(criterion);
        var inputs = criterion.querySelectorAll('input[type="radio"]');
        for (var i = 0; i < inputs.length; i++) {
            inputs[i].addEventListener('click', giveId, false);
        }
        var boxes = criterion.querySelectorAll('input[type="checkbox"]');
        for (var i = 0; i < boxes.length; i++) {
            boxes[i].addEventListener('change', changecriteria, false);
        }
    }
}

function destroy() {
    var popup = document.getElementsByClassName('dinamic')[0];
    var div = document.getElementsByClassName('popup')[0];
    popup.removeAttribute("id");
    document.body.removeChild(div);
}

function giveId() {
    var id = this.getAttribute('value');
    var form = document.getElementsByClassName('criteria')[0];
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
        
        form.querySelectorAll('[value="abb"]')[0].checked = true;
        
        break;
        
        case 'expan':
        for (var i = 0; i < ams.length; i++) {
            ams[i].style.display = 'none';
        }
        for (var i = 0; i < expans.length; i++) {
            expans[i].style.display = 'inline-block';
        }
        
        form.querySelectorAll('[value="expan"]')[0].checked = true;
        
        break;
        
        case 'reg':
        for (var i = 0; i < regs.length; i++) {
            regs[i].style.display = 'inline-block';
        }
        for (var i = 0; i < origs.length; i++) {
            origs[i].style.display = 'none';
        }
        
        form.querySelectorAll('[value="reg"]')[0].checked = true;
        
        break;
        
        case 'orig':
        for (var i = 0; i < regs.length; i++) {
            regs[i].style.display = 'none';
        }
        for (var i = 0; i < origs.length; i++) {
            origs[i].style.display = 'inline-block';
        }
        
        form.querySelectorAll('[value="orig"]')[0].checked = true;
    }
}

function changecriteria() {
    
    var id = this.getAttribute('value');
    var dels = document.querySelectorAll('del');
    var form = document.getElementsByClassName('criteria')[0];
    var adds = document.querySelectorAll('ins');
    var apostrophes = document.getElementsByClassName('supplied');
    
    switch (id) {
        case 'del':
        
        if (this.checked == true) { for (var i = 0; i < dels.length; i++) {
                dels[i].classList.remove('hide');
            }
            
            form.querySelectorAll('[value="del"]')[0].checked = true;
        } else { for (var i = 0; i < dels.length; i++) {
                dels[i].classList.add('hide');
            }
            
            form.querySelectorAll('[value="del"]')[0].checked = false;
        }
        
        break;
        
        case 'add':
        
        if (this.checked == true) {
            
            for (var i = 0; i < adds.length; i++) {
                adds[i].classList.add('enhance');
            }
            
            form.querySelectorAll('[value="add"]')[0].checked = true;
        } else { for (var i = 0; i < adds.length; i++) {
                adds[i].classList.remove('enhance');
            }
            
            form.querySelectorAll('[value="add"]')[0].checked = false;
        }
        
        
        break;
        
        case 'apostrophe':
        
        if (this.checked == false) {
            
            for (var i = 0; i < apostrophes.length; i++) {
                apostrophes[i].classList.add('hide');
            }
            
            form.querySelectorAll('[value="apostrophe"]')[0].checked = false;
        } else {
            for (var i = 0; i < apostrophes.length; i++) {
                apostrophes[i].classList.remove('hide');
            }
            
            form.querySelectorAll('[value="apostrophe"]')[0].checked = true;
        }
    }
}

window.onload = criteria;